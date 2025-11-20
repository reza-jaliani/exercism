#!/usr/bin/env bash

NumberTest() {
    if (($1 < 0)); then
        echo -e "Negative roll is invalid\n"
        exit 1
    elif (($1 > 10)); then
        echo -e "Pin count exceeds pins on the lane\n"
        exit 1
    fi
}

RegularFrames() {
    if ((FirstRoll + SecondRoll < 10)); then
        ((Score += FirstRoll + SecondRoll))
    elif ((FirstRoll == 10)) || ((FirstRoll + SecondRoll == 10)); then
        ((Score += FirstRoll + SecondRoll + ThirdRoll))
    elif ((FirstRoll + SecondRoll > 10)); then
        echo -e "Pin count exceeds pins on the lane\n"
        exit 1
    fi
    if ((FirstRoll != 10)); then
        ((++IndexA))
    fi
}

FinalFrame() {
    if ((FirstRoll != 10)); then
        if ((FirstRoll + SecondRoll > 10)); then
            echo -e "Pin count exceeds pins on the lane\n"
            exit 1
        elif ((FirstRoll + SecondRoll < 10)); then
            if ((${#RollsArray[@]} - 1 > IndexA + 1)); then
                echo -e "Cannot roll after game is over\n"
                exit 1
            fi
            ((Score += FirstRoll + SecondRoll))
        else
            if ((IndexA + 2 > ${#RollsArray[@]} - 1)); then
                echo -e "Score cannot be taken until the end of the game\n"
                exit 1
            fi
            ((Score += FirstRoll + SecondRoll + ThirdRoll))
        fi
        ((++IndexA))
    elif ((SecondRoll != 10)); then
        if ((IndexA + 2 > ${#RollsArray[@]} - 1)); then
            echo -e "Score cannot be taken until the end of the game\n"
            exit 1
        fi
        if ((SecondRoll + ThirdRoll > 10)); then
            echo -e "Pin count exceeds pins on the lane\n"
            exit 1
        fi
        ((Score += FirstRoll + SecondRoll + ThirdRoll))
        ((++IndexA))
    else
        if ((IndexA + 2 > ${#RollsArray[@]} - 1)); then
            echo -e "Score cannot be taken until the end of the game\n"
            exit 1
        fi
        ((Score += FirstRoll + SecondRoll + ThirdRoll))
        ((++IndexA))
    fi
}

Calculate() {
    for ((IndexA = 0; IndexA < ${#RollsArray[@]} - 1; ++IndexA, ++Frames)); do
        ((FirstRoll = RollsArray[IndexA]))
        ((SecondRoll = RollsArray[IndexA + 1]))
        ((ThirdRoll = RollsArray[IndexA + 2]))
        if ((Frames < 9)); then
            RegularFrames
        elif ((Frames == 9)); then
            FinalFrame
        else
            echo -e "Cannot roll after game is over\n"
            exit 1
        fi
    done
}

Main() {
    declare FirstRoll SecondRoll ThirdRoll Frames Score 
    Frames=0
    Score=0
    
    declare -a RollsArray 
    RollsArray=("$@")

    for Number in "${RollsArray[@]}"; do
        NumberTest "$Number"
    done

    Calculate

    if ((Frames < 10)); then
        echo -e "Score cannot be taken until the end of the game\n"
        exit 1
    elif ((Frames > 10)); then
        echo -e "Cannot roll after game is over\n"
        exit 1
    fi

    echo -e "$Score\n"
}

Main "$@"