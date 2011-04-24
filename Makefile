UNAME_INSTALL=install-$(shell uname -s)

update:
	git pull -q autojump
	@git update autojump
	git pull -q zsh-syntax-highlighting
	@git update zsh-syntax-highlighting
	git pull -q oh-my-zsh
	@git update oh-my-zsh
	git pull -q fizsh
	@git update fizsh

install: install-core $(UNAME_INSTALL)

install-core:
	@echo "Core install tasks."
	@echo "Backing up your .zshrc iff neccessary..."
	@!(ls $(HOME)/.zshrc > /dev/null 2> /dev/null) || mv $(HOME)/.zshrc $(PWD)/zshrc.bak # Make backup of -zshrc if necessary
	@echo "Creating .zshrc in your home directory..."
	@ln -s $(PWD)/zshrc $(HOME)/.zshrc # update the link to .zshrc
	@echo "Creating .zsh directory in your home directoy iff neccessary..."
	@ls $(HOME)/.zsh > /dev/null 2> /dev/null || ln -s $(PWD) $(HOME)/.zsh # Create .zsh dir link if not existing
	@echo "Creating $(HOME)/.local/share iff neccessary (for autojump errors)..."
	@mkdir -p $(HOME)/.local/share # Autojump writes to this dir if existing (otherwise we get a autojump_erros file)
	@echo "Creating functions.d directory iff neccessary (for autocompletion files)..."
	@mkdir -p $(PWD)/functions.d # folder for autocompletion files
	@echo "Checking out autojump iff neccessary..."
	@ls $(PWD)/autojump > /dev/null 2> /dev/null || git clone https://github.com/joelthelion/autojump.git
	@echo "Checking out zsh-syntax-highlighting iff neccessary..."
	@ls $(PWD)/zsh-syntax-highlighting > /dev/null 2> /dev/null || git clone https://github.com/nicoulaj/zsh-syntax-highlighting.git
	@echo "Checking out oh-my-zsh iff neccessary..."
	@ls $(PWD)/oh-my-zsh > /dev/null 2> /dev/null || git clone https://github.com/robbyrussell/oh-my-zsh.git
	@echo "Checking out fizsh iff neccessary..."
	@ls $(PWD)/fizsh > /dev/null 2> /dev/null || git clone git://fizsh.git.sourceforge.net/gitroot/fizsh/fizsh
	@echo "Copying autojump autocompletion script..."
	@cp -f $(PWD)/autojump/_j $(PWD)/functions.d/_j
	@echo "Creating custom user files iff neccessary..."
	@touch history private.zsh # create custom files for users
	@echo "DONE with core install tasks."
	
install-Darwin:
	@echo "Darwin specific install tasks."
	@echo "Creating $(HOME)/bin directory iff neccessary..."
	@ls $(HOME)/bin 2>&1> /dev/null || (mkdir -p $(HOME)/bin && SetFile -a "V" $(HOME)/bin) 
	@echo "Copying autojump to bin directory..."
	@ln -sf $(PWD)/autojump/autojump $(HOME)/bin/autojump
	@echo "DONE with Darwin install tasks."
	
install-Linux:
	@echo "Linux specific install tasks."
	@echo "DONE."
	
clean: 
	@echo "Cleaning up."
	@echo "Removing autojump..."
	@!(ls $(PWD)/autojump > /dev/null 2> /dev/null) || rm -r ./autojump
	@echo "Removing zsh-syntax-highlighting..."
	@!(ls $(PWD)/zsh-syntax-highlighting  > /dev/null 2> /dev/null) || rm -r ./zsh-syntax-highlighting
	@echo "Removing oh-my-zsh..."
	@!(ls $(PWD)/oh-my-zsh  > /dev/null 2> /dev/null) || rm -r ./oh-my-zsh
	@echo "Removing fizsh..."
	@!(ls $(PWD)/fizsh  > /dev/null 2> /dev/null) || rm -r ./fizsh
	@echo "DONE."
