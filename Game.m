clc;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%INITIALIZING%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load Othello.mat;
side_selection='black';

switch side_selection
    case 'white'
        selected_color_disc=whitedisc; 
        npc_disc=blackdisc;
        disc_color=0;
    case 'black'
        selected_color_disc=blackdisc;
        npc_disc=whitedisc;
        disc_color=1;
    otherwise
        fprintf('Please select a side.\n');
end

CURRENT_BOARD=[2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,0,1,2,2,2;
               2,2,2,1,0,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;];
GAME_END=0;
imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%GAMING_PROCESS%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while(~GAME_END)
    %%%%%%%%%%%%%USER_TURN%%%%%%%%%%%%%
    [user_X,user_Y]=user_turn(CURRENT_BOARD);
    CURRENT_BOARD(user_Y,user_X)=disc_color;
    Board{user_Y,user_X}=selected_color_disc;
    imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])%refresh play board
    [eat_row,eat_col]=eating_check(CURRENT_BOARD,user_Y,user_X);
    if eat_row<=8&&eat_col<=8
        CURRENT_BOARD(eat_row,eat_col)=~CURRENT_BOARD(eat_row,eat_col);
        if Board{eat_row,eat_col}==blackdisc
            Board{eat_row,eat_col}=whitedisc;
        else
            Board{eat_row,eat_col}=blackdisc;
        end
    end
    imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])%refresh play board
    
    %%%%%%%%%%%%%NPC_TURN%%%%%%%%%%%%%
    [npc_X,npc_Y]=npc_check_eligibility(CURRENT_BOARD,~disc_color);
    if npc_X<=8&&npc_Y<=8 %if returned a "good" value
        CURRENT_BOARD(npc_Y,npc_X)=~disc_color;
        Board{npc_Y,npc_X}=npc_disc;
        imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])%refresh play board
        [npc_eat_row,npc_eat_col]=eating_check(CURRENT_BOARD,npc_Y,npc_X);
        if npc_eat_row<=8&&npc_eat_col<=8
            CURRENT_BOARD(npc_eat_row,npc_eat_col)=~CURRENT_BOARD(npc_eat_row,npc_eat_col);
            if Board{npc_eat_row,npc_eat_col}==blackdisc
                Board{npc_eat_row,npc_eat_col}=whitedisc;
            else
                Board{npc_eat_row,npc_eat_col}=blackdisc;
            end
        end
        imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])%refresh play board
    end
    
    %%%%%%%%%%%%%FINISH_CHECK%%%%%%%%%%%%%
    GAME_END=finish_check(CURRENT_BOARD);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%FUNCTION_DEFINATION%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,y]=user_pos()
[user_x,user_y]=ginput(1);
user_y=631-user_y;

if user_x>0&&user_x<=83.875
    x=1;
elseif user_x>83.875&&user_x<=167.75
    x=2;
elseif user_x>167.75&&user_x<=251.625
    x=3;
elseif user_x>251.625&&user_x<=335.5
    x=4;
elseif user_x>335.5&&user_x<=419.375
    x=5;
elseif user_x>419.375&&user_x<=503.25
    x=6;
elseif user_x>503.25&&user_x<=587.125
    x=7;
elseif user_x>587.125&&user_x<=671
    x=8;
end


if user_y>0&&user_y<=78.5
    y=1;
elseif user_y>78.5&&user_y<=157
    y=2;
elseif user_y>157&&user_y<=235.5
    y=3;
elseif user_y>235.5&&user_y<=314
    y=4;
elseif user_y>314&&user_y<=392.5
    y=5;
elseif user_y>392.5&&user_y<=471
    y=6;
elseif user_y>471&&user_y<=549.5
    y=7;
elseif user_y>549.5&&user_y<=628
    y=8;
end

y=9-y;

end

function [pos_X,pos_Y]=user_turn(board)
state=0;
while ~state
    [pos_X,pos_Y]=user_pos();
    state=check_valid(board,pos_Y,pos_X);
    
    
%     state=eating_check(board,pos_Y,pos_X);
end
% board(user_Y,user_X)=1;
fprintf('USER: Row:%d Col:%d\n',pos_Y,pos_X);
end

function disc_state=check_valid(board,row,col)%white=0 black=1
if board(row,col)==2
    board(row,col)=1; %test if it is valid
    if row<=2
        if col<=2
            if board(row,col)==~board(row+1,col)&&board(row+1,col)~=2&&board(row+2,col)==board(row,col)
                disc_state=1;
            elseif board(row,col)==~board(row,col+2)&&board(row,col+1)~=2&&board(row,col+1)==board(row,col)
                disc_state=1;
            else
                disc_state=0;
            end
        elseif col>=3&&col<=6
            if board(row,col)==~board(row,col-1)&&board(row,col-1)~=2&&board(row,col-2)==board(row,col) %<-
                disc_state=1;
            elseif board(row,col)==~board(row,col+1)&&board(row,col+2)~=2&&board(row,col+2)==board(row,col) %->
                disc_state=1;
            elseif board(row,col)==~board(row+1,col)&&board(row+1,col)~=2&&board(row+1,col)==board(row,col) %downward
                disc_state=1;                                                                                
            else
                disc_state=0;
            end
        elseif col>=7
            if board(row,col)==~board(row,col-1)&&board(row,col-1)~=2&&board(row,col-2)==board(row,col) %<-
                disc_state=1;
            elseif board(row,col)==~board(row+1,col)&&board(row+1,col)~=2&&board(row+1,col)==board(row,col) %downward
                disc_state=1; 
            else
                disc_state=0;
            end
        end
    elseif row>=3&&row<=6
        if col<=2
            if board(row,col)==~board(row+1,col)&&board(row+1,col)~=2&&board(row+2,col)==board(row,col) %downward
                disc_state=1;
            elseif board(row,col)==~board(row,col+1)&&board(row,col+1)~=2&&board(row,col+1)==board(row,col) %rightward
                disc_state=1;
            elseif board(row,col)==~board(row-1,col)&&board(row-1,col)~=2&&board(row-2,col)==board(row,col) %upward
                disc_state=1; 
            else
                disc_state=0;
            end
        elseif col>=3&&col<=6
            if board(row,col)==~board(row+1,col)&&board(row+1,col)~=2&&board(row+2,col)==board(row,col) %downward
                disc_state=1;
            elseif board(row,col)==~board(row,col+1)&&board(row,col+1)~=2&&board(row,col+2)==board(row,col) %rightward
                disc_state=1;
            elseif board(row,col)==~board(row-1,col)&&board(row-1,col)~=2&&board(row-2,col)==board(row,col) %upward
                disc_state=1; 
            elseif board(row,col)==~board(row,col-1)&&board(row,col-1)~=2&&board(row,col-2)==board(row,col) %leftward
                disc_state=1;
            else
                disc_state=0;
            end
        elseif col>=7
            if board(row,col)==~board(row+1,col)&&board(row+1,col)~=2&&board(row+2,col)==board(row,col) %downward
                disc_state=1;
            elseif board(row,col)==~board(row-1,col)&&board(row-1,col)~=2&&board(row-2,col)==board(row,col) %upward
                disc_state=1;
            elseif board(row,col)==~board(row,col-1)&&board(row,col-1)~=2&&board(row,col-2)==board(row,col) %leftward
                disc_state=1;
            else
                disc_state=0;
            end
        end
    elseif row>=7
            if col<=2
                if board(row,col)==~board(row,col+1)&&board(row,col+1)~=2&&board(row,col+2)==board(row,col) %rightward
                    disc_state=1;
                elseif board(row,col)==~board(row-1,col)&&board(row-1,col)~=2&&board(row-2,col)==board(row,col) %upward
                disc_state=1; 
                else
                    disc_state=0;
                end
            elseif col>=3&&col<=6
                if board(row,col)==~board(row-1,col)&&board(row-1,col)~=2&&board(row-2,col)==board(row,col) %upward
                    disc_state=1;
                elseif board(row,col)==~board(row,col+1)&&board(row,col+1)~=2&&board(row,col+2)==board(row,col) %rightward
                    disc_state=1;
                elseif board(row,col)==~board(row,col-1)&&board(row,col-1)~=2&&board(row,col-2)==board(row,col) %leftward
                    disc_state=1;
                else
                    disc_state=0;
                end
            end
    end
else
    disc_state=0;            
end
end

function [eat_row,eat_col]=eating_check(board,row,col)
if row<=2
    if col<=2%(0,0)
        if board(row,col)~=board(row+1,col)&&board(row+1,col)~=2&&board(row,col)==board(row+2,col)
            eat_row=row+1;
            eat_col=col;
        elseif board(row,col)~=board(row,col+1)&&board(row,col+1)~=2&&board(row,col)==board(row,col+2)
            eat_row=row;
            eat_col=col+1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    elseif col>=7
        if board(row,col)~=board(row+1,col)&&board(row+1,col)~=2&&board(row,col)==board(row+2,col)
            eat_row=row+1;
            eat_col=col;
        elseif board(row,col)~=board(row,col-1)&&board(row,col-1)~=2&&board(row,col)==board(row,col-2)
            eat_row=row;
            eat_col=col-1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    else%(,3-6)
        if board(row,col)~=board(row+1,col)&&board(row+1,col)~=2&&board(row,col)==board(row+2,col)
            eat_row=row+1;
            eat_col=col;
        elseif board(row,col)~=board(row,col+1)&&board(row,col+1)~=2&&board(row,col)==board(row,col+2)
            eat_row=row;
            eat_col=col+1;
        elseif board(row,col)~=board(row,col-1)&&board(row,col-1)~=2&&board(row,col)==board(row,col-2)
            eat_row=row;
            eat_col=col-1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    end
elseif row>=7%bottom
    if col<=2
        if board(row,col)~=board(row-1,col)&&board(row-1,col)~=2&&board(row,col)==board(row-2,col)
            eat_row=row-1;
            eat_col=col;
        elseif board(row,col)~=board(row,col+1)&&board(row,col+1)~=2&&board(row,col)==board(row,col+2)
            eat_row=row;
            eat_col=col+1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
        
    elseif col>=7
        if board(row,col)~=board(row-1,col)&&board(row-1,col)~=2&&board(row,col)==board(row-2,col)
            eat_row=row-1;
            eat_col=col;
        elseif board(row,col)~=board(row,col-1)&&board(row,col-1)~=2&&board(row,col)==board(row,col-2)
            eat_row=row;
            eat_col=col-1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    else
        if board(row,col)~=board(row-1,col)&&board(row-1,col)~=2&&board(row,col)==board(row-2,col)
            eat_row=row-1;
            eat_col=col;
        elseif board(row,col)~=board(row,col-1)&&board(row,col-1)~=2&&board(row,col)==board(row,col-2)
            eat_row=row;
            eat_col=col-1;
        elseif board(row,col)~=board(row,col+1)&&board(row,col+1)~=2&&board(row,col)==board(row,col+2)
            eat_row=row;
            eat_col=col+1;
        else 
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    end
end

if col<=2
    if row>=3&&row<=6
        if board(row,col)~=board(row+1,col)&&board(row+1,col)~=2&&board(row,col)==board(row+2,col)
            eat_row=row+1;
            eat_col=col;
        elseif board(row,col)~=board(row-1,col)&&board(row-1,col)~=2&&board(row,col)==board(row-2,col)
            eat_row=row-1;
            eat_col=col;
        elseif board(row,col)~=board(row,col+1)&&board(row,col+1)~=2&&board(row,col)==board(row,col+2)
            eat_row=row;
            eat_col=col+1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    end

elseif col>=3&&col<=6
    if row>=3&&row<=6
        if board(row,col)~=board(row+1,col)&&board(row+1,col)~=2&&board(row,col)==board(row+2,col)
            eat_row=row+1;
            eat_col=col;
        elseif board(row,col)~=board(row-1,col)&&board(row-1,col)~=2&&board(row,col)==board(row-2,col)
            eat_row=row-1;
            eat_col=col;
            
        elseif board(row,col)~=board(row,col+1)&&board(row,col+1)~=2&&board(row,col)==board(row,col+2)
            eat_row=row;
            eat_col=col+1;
        elseif board(row,col)~=board(row,col-1)&&board(row,col-1)~=2&&board(row,col)==board(row,col-2)
            eat_row=row;
            eat_col=col-1;
        else
            eat_row=999; %arbitary numbers if no eating happened
            eat_col=999;
        end
    end
elseif col>=7
    if row>=3&&row<=6
        if board(row,col)~=board(row+1,col)&&board(row+1,col)~=2&&board(row,col)==board(row+2,col)
            eat_row=row+1;
            eat_col=col;
        elseif board(row,col)~=board(row-1,col)&&board(row-1,col)~=2&&board(row,col)==board(row-2,col)
            eat_row=row-1;
            eat_col=col;
        elseif board(row,col)~=board(row,col-1)&&board(row,col-1)~=2&&board(row,col)==board(row,col-2)
            eat_row=row;
            eat_col=col-1;
        else
            eat_row=999; 
            eat_col=999;
        end
    end
    
end

end

function state=finish_check(board)
k=0;
for i=1:1:8
    for j=1:1:8
        if board(i,j)~=2
            k=k+1;
        end
    end
end

if k==64
    state=1;
else
    state=0;
end
fprintf("There are totally %d disc on the board\n\n",k);
end



function [npc_row,npc_col]=npc_check_eligibility(board,npc_color)
k=1;
for i=1:1:8
    for j=1:1:8
        if board(i,j)==npc_color %white
            npc_point(k,1)=i; %row
            npc_point(k,2)=j; %col
            k=k+1;
        end
    end
end

solution_amount=size(npc_point);
solution_amount=solution_amount(1);
state=0;
k=1;
jump=0;
while ~state
    if npc_point(k,1)==1||npc_point(k,1)==2 %ROW1-2
        if npc_point(k,2)==1||npc_point(k,2)==2 %COL 1-2
            if board(npc_point(k,1)+1,npc_point(k,2))==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2))==2 %↓↓↓↓↓↓↓↓
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2);
            elseif board(npc_point(k,1),npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1),npc_point(k,2)+2)==2 %→→→→→→→→→
                npc_row=npc_point(k,1);
                npc_col=npc_point(k,2)+2;
            elseif board(npc_point(k,1)+1,npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2)+2)==2 %↘↘↘↘↘↘↘↘
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2)+2;
            else
                jump=1;
            end
        elseif npc_point(k,2)>=3&&npc_point(k,2)<=6 %COL 3-6
            if board(npc_point(k,1),npc_point(k,2)-1)==~npc_color&&board(npc_point(k,1),npc_point(k,2)-2)==2 %←←←←←←←←←
                npc_row=npc_point(k,1);
                npc_col=npc_point(k,2)-2;
            elseif board(npc_point(k,1)+1,npc_point(k,2)-1)==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2)-2)==2 %↙↙↙↙↙↙↙↙
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2)-2;
            elseif board(npc_point(k,1)+1,npc_point(k,2))==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2))==2 %↓↓↓↓↓↓↓↓
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2);
            elseif board(npc_point(k,1)+1,npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2)+2)==2 %↘↘↘↘↘↘↘↘
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2)+2;
            elseif board(npc_point(k,1),npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1),npc_point(k,2)+2)==2 %→→→→→→→→→
                npc_row=npc_point(k,1);
                npc_col=npc_point(k,2)+2;
            else
                jump=1;
            end
        elseif npc_point(k,2)==7||npc_point(k,2)==8 %COL 7-8
            if board(npc_point(k,1),npc_point(k,2)-1)==~npc_color&&board(npc_point(k,1),npc_point(k,2)-2)==2 %←←←←←←←←←
                npc_row=npc_point(k,1);
                npc_col=npc_point(k,2)-2;
            elseif board(npc_point(k,1)+1,npc_point(k,2)-1)==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2)-2)==2 %↙↙↙↙↙↙↙↙
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2)-2;
            elseif board(npc_point(k,1)+1,npc_point(k,2))==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2))==2 %↓↓↓↓↓↓↓↓
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2);
            else
                jump=1;
            end
        end %ROW 1-2 FINISHED
    elseif npc_point(k,1)>=3&&npc_point(k,1)<=6 %ROW 3-6
        if npc_point(k,2)==1&&npc_point(k,2)==2 %COL 1-2
            if board(npc_point(k,1)-1,npc_point(k,2))==~npc_color&&board(npc_point(k,1)-2,npc_point(k,2))==2 %↑↑↑↑↑↑↑↑↑↑
                npc_row=npc_point(k,1)-1;
                npc_col=npc_point(k,2);
            elseif board(npc_point(k,1)-1,npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1)-2,npc_point(k,2)+2)==2 %↗↗↗↗↗↗↗↗
                npc_row=npc_point(k,1)-2;
                npc_col=npc_point(k,2)+2;
            elseif board(npc_point(k,1),npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1),npc_point(k,2)+2)==2 %→→→→→→→→→
                npc_row=npc_point(k,1);
                npc_col=npc_point(k,2)+2;
            elseif  board(npc_point(k,1)+1,npc_point(k,2)+1)==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2)+2)==2 %↘↘↘↘↘↘↘↘
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2)+2;
            elseif board(npc_point(k,1)+1,npc_point(k,2))==~npc_color&&board(npc_point(k,1)+2,npc_point(k,2))==2 %↓↓↓↓↓↓↓↓
                npc_row=npc_point(k,1)+2;
                npc_col=npc_point(k,2);
            else
                jump=1;

    end
    
    if jump==1
        if k<solution_amount
            k=k+1; %CHECK NEXT DISC 
        end
    else
        state=1; %BREAK
    end
end

end