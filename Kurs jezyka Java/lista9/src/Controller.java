import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.fxml.FXML;
import javafx.geometry.Pos;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import javax.swing.*;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

public class Controller {
    enum States{
        EMPTY,
        REC_INP_F,
        BIN_OP,
        REC_INP_S,
        SHOW,
        ERROR
    }
    public ChoiceBox<String> numSysChoice;
    public Button btn0;
    public Button btn1;
    public Button btn2;
    public Button btn3;
    public Button btn4;
    public Button btn5;
    public Button btn6;
    public Button btn7;
    public Button btn8;
    public Button btn9;
    public Button btnA;
    public Button btnB;
    public Button btnC;
    public Button btnD;
    public Button btnE;
    public Button btnF;
    public Button btnEq;

    public Label opLabel;
    public TextField inputText;
    public Label argLabel;

    private List<Button> hex;
    private List<Button> dec;
    private List<Button> bin;

    private Model calculator;

    private States state;

    private int numSys;

    @FXML
    public void initialize() {
        calculator = new Model();
        state = States.EMPTY;

        bin = new ArrayList<>();
        bin.add(btn0);
        bin.add(btn1);

        dec = new ArrayList<>(bin);
        dec.add(btn2);
        dec.add(btn3);
        dec.add(btn4);
        dec.add(btn5);
        dec.add(btn6);
        dec.add(btn7);
        dec.add(btn8);
        dec.add(btn9);

        hex = new ArrayList<>(dec);
        hex.add(btnA);
        hex.add(btnB);
        hex.add(btnC);
        hex.add(btnD);
        hex.add(btnE);
        hex.add(btnF);

        numSysChoice.getItems().addAll("HEXAGONAL", "DECIMAL", "BINARY");
        numSysChoice.getSelectionModel().select("DECIMAL");
        numSys = 10;
    }

    @FXML
    private void pressedNum(ActionEvent e){
        Button b = (Button) e.getSource();
        String s = b.getText();
        switch (state){
            case REC_INP_F:
            case REC_INP_S:
                String tmp = inputText.getText();
                if((tmp.equals("0"))){
                    if(!s.equals("0")) inputText.setText(s);
                }
                else {
                    inputText.setText(inputText.getText() + s);
                }
                break;
            case BIN_OP:
                inputText.setText(s);
                state = States.REC_INP_S;
                break;
            case SHOW:
            case ERROR:
                reset();
            case EMPTY:
                inputText.setText(s);
                state = States.REC_INP_F;
                break;
        }
    }

    @FXML
    private void binOP(ActionEvent e){
        Button b = (Button) e.getSource();
        String s = b.getText();
        switch (state){
            case REC_INP_F:
            case SHOW:
                argLabel.setText(inputText.getText());
                opLabel.setText(s);
                inputText.setText("");
                state = States.BIN_OP;
                break;
            case BIN_OP:
                opLabel.setText(s);
                break;
        }
    }

    public void eval(){
        if (state == States.REC_INP_S) {
            String res = calculator.eval(argLabel.getText(), opLabel.getText(), inputText.getText(), numSys);
            argLabel.setText(argLabel.getText() + " " + opLabel.getText() + " " + inputText.getText());
            opLabel.setText("=");
            inputText.setText(res);
            if(res.equals("ERROR")) {
                state = States.ERROR;
            }
            else {
                state = States.SHOW;
            }

        }
    }

    public void evalFact(){
        if(state == States.REC_INP_F || state == States.SHOW){
            String res = calculator.eval(inputText.getText(), "!", numSys);
            argLabel.setText(inputText.getText() + " !");
            opLabel.setText("=");
            inputText.setText(res);
            if(res.equals("ERROR")){
                state = States.ERROR;
            }
            else{
                state = States.SHOW;
            }
        }
    }

    public void changeSign(){
        switch (state){
            case REC_INP_F:
            case REC_INP_S:
                String tmp = inputText.getText();
                if(!tmp.equals("0")){
                    if(tmp.charAt(0) == '-') {
                        inputText.setText(tmp.substring(1));
                    }
                    else {
                        inputText.setText("-" + tmp);
                    }
                }
                break;
        }
    }

    public void remove(){
        String input = inputText.getText();
        int len = input.length();
        switch (state){
            case REC_INP_F:
                if(len == 1 || (len == 2 && input.charAt(0) == '-')){
                    reset();
                }
                else{
                    inputText.setText(input.substring(0, len-1));
                }
                break;
            case REC_INP_S:
                if(len == 1 || (len == 2 && input.charAt(0) == '-')){
                    state = States.BIN_OP;
                    inputText.setText("");
                }
                else{
                    inputText.setText(input.substring(0, len-1));
                }
                break;

        }
    }

    public void reset(){
        state = States.EMPTY;
        inputText.setText("");
        opLabel.setText("");
        argLabel.setText("");
    }

    public void changeNumSys() {
        String s = numSysChoice.getSelectionModel().getSelectedItem();
        switch(s){
            case "BINARY":
                if(numSys != 2){
                    for(Button b: hex){
                        b.setDisable(true);
                    }
                    for(Button b: bin){
                        b.setDisable(false);
                    }
                    numSys = 2;
                    reset();
                }
                break;
            case "DECIMAL":
                if(numSys != 10){
                    for(Button b: hex){
                        b.setDisable(true);
                    }
                    for(Button b: dec){
                        b.setDisable(false);
                    }
                    numSys = 10;
                    reset();
                }
                break;
            case "HEXAGONAL":
                if(numSys != 16){
                    for(Button b: hex){
                        b.setDisable(false);
                    }
                    numSys = 16;
                    reset();
                }
                break;

        }
    }
}
