clc;
clear;


load Othello.mat;


CURRENT_BOARD=[2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,0,1,2,2,2;
               2,2,2,1,0,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;
               2,2,2,2,2,2,2,2;]; %white is 0 black is 1

imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])

game_state=1; %start

while game_state %main thread
    CURRENT_BOARD=user_step(CURRENT_BOARD);
    for i=1:1:8
        for j=1:1:8
            if CURRENT_BOARD(i,j)==1
                Board{i,j}=blackdisc;
            elseif CURRENT_BOARD(i,j)==0
                Board{i,j}=whitedisc;
            end
        end
    end %update graphic board
    imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])
    
    pause(0.4);
    
    CURRENT_BOARD=npc_step(CURRENT_BOARD);
    for i=1:1:8
        for j=1:1:8
            if CURRENT_BOARD(i,j)==1
                Board{i,j}=blackdisc;
            elseif CURRENT_BOARD(i,j)==0
                Board{i,j}=whitedisc;
            end
        end
    end %update graphic board
    imshow([Board{1,:};Board{2,:};Board{3,:};Board{4,:};Board{5,:};Board{6,:};Board{7,:};Board{8,:}])
    
    
    [game_state,black_number,white_number]=counter(CURRENT_BOARD);
end


function board_output=user_step(board)
    state=0;
    while state==0
       [row,col]=user_pos(); 
       state=validity_check(board,row,col,1);
    end
    board(row,col)=1;
    board=flipping_disc(board,row,col,1);
    
    board_output=board;
end

function [row,col]=user_pos()
    [user_x,user_y]=ginput(1);
    user_y=631-user_y;
    
    if user_x>0&&user_x<=83.875
        col=1;
    elseif user_x>83.875&&user_x<=167.75
        col=2;
    elseif user_x>167.75&&user_x<=251.625
        col=3;
    elseif user_x>251.625&&user_x<=335.5
        col=4;
    elseif user_x>335.5&&user_x<=419.375
        col=5;
    elseif user_x>419.375&&user_x<=503.25
        col=6;
    elseif user_x>503.25&&user_x<=587.125
        col=7;
    elseif user_x>587.125&&user_x<=671
        col=8;
    end
    
    
    if user_y>0&&user_y<=78.5
        row=1;
    elseif user_y>78.5&&user_y<=157
        row=2;
    elseif user_y>157&&user_y<=235.5
        row=3;
    elseif user_y>235.5&&user_y<=314
        row=4;
    elseif user_y>314&&user_y<=392.5
        row=5;
    elseif user_y>392.5&&user_y<=471
        row=6;
    elseif user_y>471&&user_y<=549.5
        row=7;
    elseif user_y>549.5&&user_y<=628
        row=8;
    end
    
    row=9-row;
end

function state = validity_check(board,row,col,playerTurn)
    state=0;
    jump=0;%initialization
    if board(row,col)==2
        if state==0&&col<7
            for j=col+1:1:7 % right horizontal direction
            if (playerTurn == 0)    
                switch board(row,j)
                    case 0
                        if j==col+1
                            state=0;
                        else
                            state=1;
                            jump=1; %jump
                        end
                    case 1
                        % do nothing
                    case 2
                        state=0;
                        jump=1; %jump
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(row,j)
                    case 0
                        % Do nothing
                    case 1
                        if j==col+1
                            state=0;
                        else
                            state=1;
                            jump=1; %jump
                        end
                    case 2
                        state=0;
                        jump=1;
                end 
            end
            if jump
                jump=0;
                break;
            end
            end  
        end %?????
        
        if state==0&&col>2
            for j=col-1:-1:2 % left horizontal direction
            if (playerTurn == 0) %npc   
                switch board(row,j)
                    case 0
                        if j==col-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                    
                    case 2
                        state = 0;
                        jump=1;
                end 
            elseif (playerTurn == 1)
                switch board(row,j)
                    case 0
                    
                    case 1
                        if j==col-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 2
                        state=0;
                        jump=1;
                end 
            end
            if jump
                jump=0;
                break;
            end
            end 
        end %?????
        
        if state==0&&row<7
            for i=row+1:1:7 % down vertical direction
            if (playerTurn == 0)    
                switch board(i,col)
                    case 0
                        if i==row+1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,col)
                    case 0
                        
                    case 1
                        if i==row+1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 2
                        state=0;
                        jump=1;
                end 
            end
            if jump
                jump=0;
                break;
            end
            end 
        end %?????
        
        if state==0&&row>2
            for i=row-1:-1:2 % up vertical direction
            if (playerTurn == 0)    
                switch board(i,col)
                    case 0
                        if i==row-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,col)
                    case 0
                        
                    case 1
                        if i==row-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 1
            end % end if-else statement
            if jump
                jump=0;
                break;
            end
            end % end for i loop
        end %?????
        
        if state==0&&col<7&&row<7
            for i=row+1:1:7 % down-right direction
            j=i-row+col; 
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row+1&&j==col+1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        
                    case 1
                        if i==row+1&&j==col+1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 1
            end % end if-else statement
            if jump
                jump=0;
                break;
            end
            end % end for i loop
        end %?????
        
        if state==0&&col>2&&row<7
            for i=row+1:1:7 % down-left direction
            j=row-i+col;
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row+1&&j==col-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        
                    case 1
                        if i==row+1&&j==col+1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 2
                        state=0;
                        jump=1;
                end 
            end
            if jump
                jump=0;
                break;
            end
            end 
        end %?????
        
        if state==0&&col<7&&row>2
            for i=row-1:-1:2 % up-right direction
            j=row-i+col;
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row-1&&j==col-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        
                    case 1
                        if i==row-1&&j==col+1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 1
            end % end if-else statement
            if jump
                jump=0;
                break;
            end
            end % end for i loop
        end %?????
        
        if state==0&&col>2&&row>2
            for i=row-1:-1:2 % up-left direction
            j=i-row+col;
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row-1&&j==col-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        jump=1;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        if i==row-1&&j==col-1
                            state=0;
                            jump=1;
                        else
                            state=1;
                            jump=1;
                        end
                    case 1
                        
                    case 2
                        jump=1;
                end % end switch playerTurn 1
            end % end if-else statement  
            if jump
                jump=0;
                break;
            end
            end % end for i loop
        end %?????
    end
end 

function board_flip_output=flipping_disc(board,row,col,playerTurn) %Player=1 NPC=0
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    jump=0; %initialization
    flip_number=0;
    flip_disc=[];
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if col<7
        for j=col+1:1:7 % right horizontal direction
        if (playerTurn == 0)    
            switch board(row,j)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=row;
                    flip_disc(flip_number,2)=j;
                case 2
                    flip_disc=previous_state;
                    previous_number=flip_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(row,j)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=row;
                    flip_disc(flip_number,2)=j;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    previous_number=flip_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement  
        if jump
            jump=0;
            break;
        end
        end  % end for j loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if col>2
        for j=col-1:-1:2 % left horizontal direction
        if (playerTurn == 0)    
            switch board(row,j)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=row;
                    flip_disc(flip_number,2)=j;
                case 2
                    flip_disc=previous_state;
                    previous_number=flip_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(row,j)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=row;
                    flip_disc(flip_number,2)=j;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    previous_number=flip_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement
        if jump
            jump=0;
            break;
        end
        end % end for j loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if row<7
        for i=row+1:1:7 % down vertical direction
        if (playerTurn == 0)    
            switch board(i,col)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=col;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,col)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=col;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement
        if jump
            jump=0;
            break;
        end
        end % end for i loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if row>2
        for i=row-1:-1:2 % up vertical direction
        if (playerTurn == 0)    
            switch board(i,col)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=col;
                case 2
                    flip_state=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,col)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=col;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement
        if jump
            jump=0;
            break;
        end
        end % end for i loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if col<7&&row<7
        for i=row+1:1:7 % down-right direction
        j=i-row+col; 
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement  
        if jump
            jump=0;
            break;
        end
        end % end for i loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if col>2&&row<7
        for i=row+1:1:7 % down-left direction
        j=row-i+col;
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 1
         end % end if-else statement  
         if jump
            jump=0;
            break;
         end
        end % end for i loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if col<7&&row>2
        for i=row-1:-1:2 % up-right direction
        j=row-i+col;
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement  
        if jump
            jump=0;
            break;
        end
        end % end for i loop
    end
    
    previous_state=flip_disc;
    previous_number=flip_number;
    if col>2&&row>2
        for i=row-1:-1:2 % up-left direction
        j=i-row+col;
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    jump=1;
                case 1
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
             end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    flip_number=flip_number+1;
                    flip_disc(flip_number,1)=i;
                    flip_disc(flip_number,2)=j;
                case 1
                    jump=1;
                case 2
                    flip_disc=previous_state;
                    flip_number=previous_number;
                    jump=1;
            end % end switch playerTurn 1
        end % end if-else statement  
        if jump
            break;
        end
        end % end for i loop
    end
    
    %FOR DEGUBBING
    fprintf("\n%d %d\n",row,col);
    %END
    
    if playerTurn&&flip_number>0
        for i=1:1:flip_number
            if flip_disc(i,1)~=0&&flip_disc(i,2)~=0
                board(flip_disc(i,1),flip_disc(i,2))=1;
            end
        end
    elseif ~playerTurn&&flip_number>0
        for i=1:1:flip_number
            if flip_disc(i,1)~=0&&flip_disc(i,2)~=0
                board(flip_disc(i,1),flip_disc(i,2))=0;
            end
        end
    end
    
    board_flip_output=board;
end

function board_output=npc_step(board)
    state=0;
    jump=0;
%     for i=1:1:8
%         for j=1:1:8
%             if board(i,j)==0
%                 npc_number=npc_number+1;
%                 npc_point(npc_number,1)=i; %find row
%                 npc_point(npc_number,2)=j; %find column
%             end
%         end
%     end



    for i=1:1:8 %search the first valid coordinate
        for j=1:1:8
            state=validity_check(board,i,j,0);
            if state
                board(i,j)=0;
                fprintf("Valid point found:%d %d\n",i,j);
                board=flipping_disc(board,i,j,0);
                jump=1;
            end
            if jump
                break;
            end
        end
        if jump
            jump=0;
            break;
        end
    end
    
    board_output=board;
            
end

function [state,black_number,white_number]=counter(board)
    black_number=0;
    white_number=0;
    total_number=0;
    validity_state=1;
    for i=1:1:8
        for j=1:1:8
            if board(i,j)==1
                validity_state=validity_check(board,i,j,1);
                black_number=black_number+1;
                total_number=total_number+1;
            elseif board(i,j)==0
                validity_state=validity_check(board,i,j,0);
                white_number=white_number+1;
                total_number=total_number+1;
            end
        end
    end
    if total_number==64
        state=0;
    else
        state=1;
    end
end
