# GNU PARAMETERS
NAME	:=	ftprintf
#CFLAGS	:=	-Werror -Wextra -Wall
CC		:=	gcc

# LIBRARIES
LIB_PATH	:=	libft
LIB			:=	$(LIB_PATH)/libft.a
LIB_LINK	:=	-L $(LIB_PATH) -lft

# INCLUDES
INCS		:=	-I $(LIB_PATH) -I $(SRCS_DIR)

# SOURCES
SRCS_DIR :=	srcs
SRCS	:=		main.c				\
				ft_printf.c			\
				parser/parser.c		\
				parser/utils.c		\
				parser/helper.c

SRCS_FILES 	:= $(addprefix $(SRCS_DIR)/,$(SRCS))
# OBJECTS
OBJS		:=	$(SRCS_FILES:.c=.o)

# TERMINAL COMMANDS
RM			:= /bin/rm -rf

# COLORS
LOG_CLEAR		= \033[2K
LOG_NOCOLOR		= \033[0m
LOG_BOLD		= \033[1m
LOG_RED			= \033[1;31m
LOG_GREEN		= \033[32m
LOG_VIOLET		= \033[1;35m

.PHONY: clean fclean re norme

all : $(NAME)

$(NAME) : $(LIB) $(OBJS)
	@$(CC) $(CFLAGS) -o $@ $^ $(LIB_LINK)
	@echo "$(LOG_GREEN)$(NAME) CREATED SUCCESSFULLY$(LOG_NOCOLOR)"

$(LIB)	:
	@echo "$(LOG_CLEAR)$(LOG_VIOLET)$(LOG_BOLD)BEGIN COMPILING ...$(LOG_NOCOLOR)"
	@make -C $(LIB_PATH)

%.o		: $(SRCS_DIR)/%.c
	@echo "$(LOG_CLEAR)	👉  add $@	✅ $(LOG_NOCOLOR)"
	@$(CC) $(CFLAGS) $(INCS) -o $@ -c $<
	
norme :
	@clear
	@make norme -C $(LIB_PATH)
	@norminette $(SRCS)
	@norminette $(INC_DIR)

clean:
	@$(RM) $(OBJS)
	@make fclean -C $(LIB_PATH)
	@echo "$(LOG_CLEAR)$(LOG_RED)OBJECT FILES GO TO 🗑️$(LOG_NOCOLOR)"

fclean : clean
	@$(RM) $(NAME)
	@make fclean -C $(LIB_PATH)
	@echo "$(LOG_RED)REMOVE $(NAME) SUCCESSFULLY 🗑️$(LOG_NOCOLOR)"
	@echo ""
	@echo ""

re : fclean all