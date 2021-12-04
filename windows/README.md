# Windows Setup

Problemas encontrados e soluções para configurar um ambiente de desenvolvimento no Windows com WSL.

## slow git clone: file system in general taking too long to write/read files & slow networking bandwidth
As operações de I/O em geral estão lentas, apenas no ambiente wsl.

Certifique-se de que tudo que precisa está no diretório linux. projetos, etc. O wsl pode ser lento lendo arquivos do Windows.

No ininio estava meio lento o meu wsl, fiz algumas coisas, mas me perdi no caminho e não sei exatamente se houve um problema, ou era minha internet q estava lenta e eu achei q a escrita no disco estava lenta durante o git clone dos projetos.

__Rereência:__ https://github.com/microsoft/WSL/issues/4197



## slow git clone: slow networking bandwidth
A comunicação na internet é ruim, apenas no ambiente wsl. Pode ser um problema no dns simples de dns.

**Solução:**
Alterar o dns do wsl. Antes de fazer isso, ver [Laravel valet](## Laravel valet) abaixo.
```sh
sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo bash -c 'echo "[network]" > /etc/wsl.conf'
sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo chattr +i /etc/resolv.conf
```

Acredito que as duas se completão. Me perdi no meio do processo dessas soluções, mas executando nessa ordem, deve funcionar.

__Referência:__: https://github.com/microsoft/WSL/issues/4901#issuecomment-955600309

## dnsmask: custom domain not accessible on windows' browsers
O laravel valet instala o dnsmask para permitir que domínio customizado possa ser utilizado. Por exemplo, domínios que terminarem com `*.test` são resolvidos no ip 127.0.0.1.

O curl no wsl consegue resolver esse domínio normalmente. 

**Solução:**
Esse é um problema ainda sem solução final no wsl. Mas uma solução paleativa é adicionar os domínios desejados no arquivo `C:\Windows\System32\Drivers\etc\hosts`

Exemplo:
```
postgrain-api.test              localhost
postgrain-intranet.test         localhost
```

Talvez, também seja necessário utilizar o ip `127.0.0.1` como dns padrão do windows. O dns secundário pode ser qualquer outro, como o cloudflare `1.1.1.1`. Para ipv6, basta colocar o dns primário com o valor `::1`.

__Referência:__: https://github.com/microsoft/WSL/discussions/4592

## Laravel valet: wsl lost internet connection after install valet
Durante a instalação do valet, o arquivo /etc/resolv.conf é sobre-escrito, removendo o comando nameserver,
necessário para resolução do nome de domínio (dns).

**Solução:**
Abrir o arquivo /etc/resolv.conf e adicionar o comando abaixo na primeira linha do arquivo, sem apagar o que já existe no arquivo - comandos do valet.
```sh
$ sudo vim /etc/resolv.conf
```

Colar: `nameserver 172.17.194.113` após `#!/usr/bin/env bash`.

__Referência:__ https://github.com/microsoft/WSL/issues/6069#issuecomment-708376792

## WSL VSCode: code . dentro do wsl não abre o vscode com a extensão wsl remote
O comando `code .` utilizado para abrir uma pasta, sendo executado dentro do wsl, nâo executa a extensão wsl remote, mas abre o vscode. No terminal que executou o comando, aparece um erro de permissão de escrita no arquivo: `/tmp/remote-wsl-loc.txt permission denied`.

Isso acontece pq o arquivo `/tmp/remote-wsl-loc.txt` foi criado um usuário diferente do utilizado pelo wsl. Possivelmente, houve uma troca de usuário na configuração do wsl, de root par um usuário comum.

**Solução:**
Alterar permissão do arquivo `/tmp/remote-wsl-loc.txt` para que o usuário default do wsl possa escrever nele. Na solução abaixo, será liberado escriva na pasta `/tmp` inteira.
```sh
$ sudo chown -R ubuntu:ubuntu /tmp
```

__Referência:__ https://github.com/microsoft/vscode-remote-release/issues/5389