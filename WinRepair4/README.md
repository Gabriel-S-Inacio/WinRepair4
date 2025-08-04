# WinRepair4

Ferramenta de Reparo Avançado para Windows 10/11 nas versões `.bat` e PowerShell `.ps1`.

---

## Como usar

### Requisitos

- **Executar como Administrador** (necessário para que todas as funções funcionem corretamente)
- No PowerShell, talvez seja necessário ajustar a política de execução para permitir scripts:

  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
````

---

### Executando a versão `.bat`

1. Clique com o botão direito no arquivo `WinRepair4.bat`
2. Selecione **Executar como Administrador**
3. Use o menu para escolher a opção desejada

---

### Executando a versão PowerShell `.ps1`

1. Abra o PowerShell como Administrador

2. Navegue até a pasta onde o script está, por exemplo:

   ```powershell
   cd C:\Caminho\Para\Pasta\WinRepair4
   ```

3. Configure o console para UTF-8 para suporte a acentuação:

   ```powershell
   chcp 65001
   ```

4. Execute o script:

   ```powershell
   .\WinRepair4.ps1
   ```

---

### Observações importantes

* ⚠️ **Erros podem ocorrer** dependendo da configuração do sistema, permissões ou políticas de segurança.

* Se receber erro relacionado à política de execução de scripts no PowerShell, ajuste com:

  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

* Para **reverter** a política de execução e bloquear novamente a execução de scripts, use:

  ```powershell
  Set-ExecutionPolicy Restricted -Scope CurrentUser
  ```
 
 
## Nota do Autor

Este projeto foi desenvolvido com o apoio de ferramentas de inteligência artificial para acelerar o processo de criação e organização do código. Todo o script foi revisado e testado integralmente por mim, Gabriel Santos Inácio, em máquinas virtuais e sistemas reais.

Durante os testes, observei que o script funciona normalmente na maioria dos ambientes Windows 10 e 11, porém, devido à variedade de configurações de sistemas, sempre existe a possibilidade de ocorrerem erros ou comportamentos inesperados.

Se você encontrar algum problema, sugestão ou melhoria, fique à vontade para abrir uma issue ou enviar um pull request. Sua contribuição é muito bem-vinda para tornar essa ferramenta cada vez melhor!

---

Obrigado por visitar e utilizar o WinRepair4!

Gabriel Santos Inácio
