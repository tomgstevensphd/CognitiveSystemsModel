NIL
;;FOLLOWING WORKS FOR 100 100 300 300 MID
#|           (setf sel-node1pt-x 200 sel-node1pt-y 130
                      sel-node2pt-x 300 sel-node2pt-y 330)|#

BEFORE SETTING SLOT-VALUES:
R-MIDPT-X= 200  R-MIDPT-Y= 130.0  XX OK
L-midpt-x= 100 L-midpt-y= 130.0
SLOT= NODE1-PTS  
BEFORE SETTING SLOT-VALUES:
R-midpt-x= 400  R-midpt-y= 330.0 
L-MIDPT-X= 300 L-MIDPT-Y= 330.0  XX OK
SLOT= NODE2-PTS  


2 BEFORE MVB 
NODE1-PTS= (100 110.0 200 110.0 100 130.0 [200 130.0 OK] 100 150.0 200 150.0)
NODE2-PTS= (300 310.0 400 310.0 [300 330.0 OK] 400 330.0 300 350.0 400 350.0)


AFTER VALUES-LIST
R-midpt1-x= 130.0  R-midpt1-y= 100  [VS 200, 130.0  XXX WRONG ]           
L-midpt2-x= 330.0  L-midpt2-y= 400  [VS 300, 330.0  XXX WRONG ]  

AFTER SETTING SEL VALUES:  [SET SAME AS ABOVE--WORKED?]
 sel-node1pt-x= 130.0  sel-node1pt-y = 200 
sel-node2pt-x = 330.0  sel-node2pt-y= 300   


AFOUT path-message=  sel-node1pt-x= 130.0  sel-node1pt-y = 200 sel-node2pt-x = 330.0  sel-node2pt-y= 300   
slot-value=  sel-node1pt-x= 130.0  sel-node1pt-y = 200 sel-node2pt-x = 330.0  sel-node2pt-y= 300   

;;XXX AFTER FIXED MVB

NIL

BEFORE SETTING SLOT-VALUES:
R-MIDPT-X= 200  R-MIDPT-Y= 130.0  OK
L-midpt-x= 100 L-midpt-y= 130.0
SLOT= NODE1-PTS  


BEFORE SETTING SLOT-VALUES:
R-midpt-x= 400  R-midpt-y= 330.0  
L-MIDPT-X= 300 L-MIDPT-Y= 330.0  OK
SLOT= NODE2-PTS  


2 BEFORE MVB NODE1-PTS= (100 110.0 200 110.0 100 130.0 [200 130.0 OK] 100 150.0 200 150.0)
NODE2-PTS= (300 310.0 400 310.0 [300 330.0 OK] 400 330.0 300 350.0 400 350.0)
AFTER VALUES-LIST
R-midpt1-x= 200  R-midpt1-y= 130.0  OK--FIXED
L-midpt2-x= 300  L-midpt2-y= 330.0  OK--FIXED


AFTER SETTING SEL VALUES:
 sel-node1pt-x= 100 V 200  sel-node1pt-y = 130.0 OK
sel-node2pt-x = 400 V 300 sel-node2pt-y= 330.0  OK  


AFOUT path-message=  sel-node1pt-x= 100  sel-node1pt-y = 130.0 sel-node2pt-x = 400  sel-node2pt-y= 330.0   
slot-value=  sel-node1pt-x= 100  sel-node1pt-y = 130.0 sel-node2pt-x = 400  sel-node2pt-y= 330.0   

