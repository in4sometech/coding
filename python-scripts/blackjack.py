# Welcome message
import time

print("** Welcome to Blackjack game on python **")
print("This is a two player game with one being computer\n")
import random
import sys

totald = 0
totalp = 0
s = 0
n = 0
d = 0
p = 0
# dt = 0
global pt
global key
pt = 0
key = 0

def print_slow(str):
   for letter in str:
    sys.stdout.write(letter)
    sys.stdout.flush()
    time.sleep(0.1)


def game_serve_first():
    global n
    global p
    global d
    global pt
    global dt
    global playertotal
    global dealertotal
    global dealertop
    global dealertotalwithoutfirst
    dealertop = 0
    pt = 0
    dt = 0
    print("The dealer is mixing cards", end =" ")
    print_slow("************")
    #print("**", end=" ")
    d = random.randint(1, 11)
    p = random.randint(1, 11)
    pt = pt + p
    dt = dt + d
    print("/n")
    print("Player first card  is     --> ", end =" ")
    print(p)
    d = random.randint(1, 11)
    p = random.randint(1, 11)
    #playertotal = playertotal + p
    pt = pt + p
    dealertop = d
    dt = dt + d
    print("Player Second card  is    --> ",p)
    #print(p)
    print("\n")
    print("Player total  is  ", end =" ")
    print(pt, "\n")
    print("Dealer top card is ", end =" ")
    print(dealertop, "\n")
    # print("Dealer number is Hidden from player \n",end=" ")
    if pt == 21:
        pblackjack()
    if dt == 21:
        dblackjack()
    print("Hi Player, Please press 1 for new card, or any key to drop the game \n")
    n = input()

game_serve_first()

def pblackjack():
    print("Player has blackjack, so Player Won, Wohooooooooooooo")
    sys.exit()

def dblackjack():
    print("Dealer has blackjack, so Python Won, Wohooooooooooooo")
    sys.exit()

def gameplay():
    playertotal = 0
    key = 0
    dealertotalwithoutfirst = 0
    print("The dealer is mixing cards", end=" ")
    print_slow("************")
    print("\n")
    d = random.randint(1, 11)
    p = random.randint(1, 11)
    playertotal = p + pt
    print("Player New  card  is     --> ", p)
    print("Dealer New  card  is     --> ", d)
    print("\n")
    print("Player total is ", playertotal)
    print("\n")
    dealertotalwithoutfirst = dealertop + d
    print("Dealer total without first card is", dealertotalwithoutfirst)
    print("\n")
    if playertotal == 21:
        pblackjack()
    if playertotal > 21:
        playerlost()
    else:
        print(" Hi Player press 1 for new card, or any key to drop the game")
        key = input()




def playerlost():
    print("Player exceed the total of 21 with value ")
    print("Player lost the game")
    sys.exit()

def gameover():
    print("Player total is ", pt)
    print("Dealertotal is ", dt)
    if pt >= dt and pt <= 21:
        print("Player won based on the highest total", pt)
        # elif dt
    else:
        print("Dealer won based on the highest total", dt)

def dealerwon():
    print("Dealer total is ################", dealertotal)
    print("Sorry,PYTHON Won the Game")


if n == '1' or key == '1':
    print("Player want new card \n")
    gameplay()

    # game_serve()
    #playertotal = playertotal + p
    #pt = pt + p
    #print("playertotal  is", pt)
    #dealertotal = dealertotal + d
    #dt
   # if dealertotal <= 21:
     #   dealerwon()
     #   print("dealerwon")
else:
    gameover()
    print("Game done")

# print("Bye")
