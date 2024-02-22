create or replace view aggView6536755722141158664 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin1120106044051391250 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6536755722141158664 where Message_hasCreator_Person.MessageId=aggView6536755722141158664.v1;
create or replace view aggView4162301129556424538 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2769818908845773852 as select v1, aggJoin1120106044051391250.annot * aggView4162301129556424538.annot as annot from aggJoin1120106044051391250 join aggView4162301129556424538 using(v1);
create or replace view aggView1360266980870043051 as select v1, SUM(annot) as annot from aggJoin2769818908845773852 group by v1;
create or replace view aggJoin8531758598649896009 as select annot from Person_likes_Message as Person_likes_Message, aggView1360266980870043051 where Person_likes_Message.MessageId=aggView1360266980870043051.v1;
select SUM(annot) as v9 from aggJoin8531758598649896009;
