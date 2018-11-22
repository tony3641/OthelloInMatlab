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
while game_state

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
    
    while state==0 
        for j=col+1:1:7 % right horizontal direction
            if (playerTurn == 0)    
                switch board(row,j)
                    case 0
                        if j==col+1
                            state=0;
                        else
                            state=1;
                            break; %jump
                        end
                    case 1
                        % do nothing
                    case 2
                        state=0;
                        break; %jump
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
                            break; %jump
                        end
                    case 2
                        state=0;
                        break;
                end 
            end   
        end  
    end %?????

    while state==0
        for j=col-1:-1:2 % left horizontal direction
            if (playerTurn == 0) %npc   
                switch board(row,j)
                    case 0
                        if j==col-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                    
                    case 2
                        state = 0;
                        break;
                end 
            elseif (playerTurn == 1)
                switch board(row,j)
                    case 0
                    
                    case 1
                        if j==col-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 2
                        state=0;
                        break;
                end 
            end 
        end 
    end %?????
    
    while state==0
        for i=row+1:1:7 % down vertical direction
            if (playerTurn == 0)    
                switch board(i,col)
                    case 0
                        if i==row+1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,col)
                    case 0
                        
                    case 1
                        if i==row+1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 2
                        state=0;
                        break;
                end 
            end 
        end 
    end %?????
    
    while state==0
        for i=row-1:-1:2 % up vertical direction
            if (playerTurn == 0)    
                switch board(i,col)
                    case 0
                        if i==row-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,col)
                    case 0
                        
                    case 1
                        if i==row-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 1
            end % end if-else statement
        end % end for i loop
    end %?????
    
    while state==0
        for i=row+1:1:7 % down-right direction
            j=i-row+col; 
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row+1&&j==col+1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        
                    case 1
                        if i==row+1&&j==col+1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 1
            end % end if-else statement  
        end % end for i loop
    end %?????
    
    while state==0
        for i=row+1:1:7 % down-left direction
            j=row-i+col;
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row+1&&j==col-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        
                    case 1
                        if i==row+1&&j==col+1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 2
                        state=0;
                        break;
                end 
            end  
        end 
    end %?????
    
    while state==0
        for i=row-1:-1:2 % up-right direction
            j=row-i+col;
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row-1&&j==col-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        
                    case 1
                        if i==row-1&&j==col+1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 1
            end % end if-else statement  
        end % end for i loop
    end %?????
    
    while state==0
        for i=row-1:-1:2 % up-left direction
            j=i-row+col;
            if (playerTurn == 0)    
                switch board(i,j)
                    case 0
                        if i==row-1&&j==col-1
                            state=0;
                            break;
                        else
                            state=1;
                            break;
                        end
                    case 1
                        
                    case 2
                        state=0;
                        break;
                end % end switch playerTurn 0
            elseif (playerTurn == 1)
                switch board(i,j)
                    case 0
                        board(i,j) = 1;
                    case 1
                        break;
                    case 2
                        break;
                end % end switch playerTurn 1
            end % end if-else statement  
        end % end for i loop
    end %?????
    
end 


function board_flip_output=flipping_disc(board,row,col,playerTurn) %Player=1 NPC=0
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    
    for j=col+1:1:7 % right horizontal direction
        if (playerTurn == 0)    
            switch board(row,j)
                case 0
                    break;
                case 1
                    board(row,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(row,j)
                case 0
                    board(row,j) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement  
    end  % end for j loop
    
    for j=col-1:-1:2 % left horizontal direction
        if (playerTurn == 0)    
            switch board(row,j)
                case 0
                    break;
                case 1
                    board(row,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(row,j)
                case 0
                    board(row,j) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement
    end % end for j loop
    
    for i=row+1:1:7 % down vertical direction
        if (playerTurn == 0)    
            switch board(i,col)
                case 0
                    break;
                case 1
                    board(row,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,col)
                case 0
                    board(i,col) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement
    end % end for i loop
    
    for i=row-1:-1:2 % up vertical direction
        if (playerTurn == 0)    
            switch board(i,col)
                case 0
                    break;
                case 1
                    board(row,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,col)
                case 0
                    board(i,col) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement
    end % end for i loop
    
    for i=row+1:1:7 % down-right direction
        j=i-row+col; 
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    break;
                case 1
                    board(i,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    board(i,j) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement  
    end % end for i loop
    
    for i=row+1:1:7 % down-left direction
        j=row-i+col;
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    break;
                case 1
                    board(i,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    board(i,j) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
         end % end if-else statement  
    end % end for i loop
    
    for i=row-1:-1:2 % up-right direction
        j=row-i+col;
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    break;
                case 1
                    board(i,j) = 0;
                case 2
                    break;
            end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    board(i,j) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement  
    end % end for i loop
    
    for i=row-1:-1:2 % up-left direction
        j=i-row+col;
        if (playerTurn == 0)    
            switch board(i,j)
                case 0
                    break;
                case 1
                    board(i,j) = 0;
                case 2
                    break;
             end % end switch playerTurn 0
        elseif (playerTurn == 1)
            switch board(i,j)
                case 0
                    board(i,j) = 1;
                case 1
                    break;
                case 2
                    break;
            end % end switch playerTurn 1
        end % end if-else statement  
    end % end for i loop

    board_flip_output=board;
end

