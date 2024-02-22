create or replace view aggView5796316003714498897 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4395820847063128362 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5796316003714498897 where Message_hasCreator_Person.MessageId=aggView5796316003714498897.v1;
create or replace view aggView361585870937886246 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin1915545460108325330 as select v1, aggJoin4395820847063128362.annot * aggView361585870937886246.annot as annot from aggJoin4395820847063128362 join aggView361585870937886246 using(v1);
create or replace view aggView128414454386828034 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8104186936199044250 as select aggJoin1915545460108325330.annot * aggView128414454386828034.annot as annot from aggJoin1915545460108325330 join aggView128414454386828034 using(v1);
select SUM(annot) as v9 from aggJoin8104186936199044250;
