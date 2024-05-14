create or replace view aggView5383826763987677207 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4365944334352404811 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5383826763987677207 where Message_hasCreator_Person.MessageId=aggView5383826763987677207.v1;
create or replace view aggView3353721184443733012 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin4993324097962734627 as select v1, aggJoin4365944334352404811.annot * aggView3353721184443733012.annot as annot from aggJoin4365944334352404811 join aggView3353721184443733012 using(v1);
create or replace view aggView484897216971134583 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2291075598183985028 as select aggJoin4993324097962734627.annot * aggView484897216971134583.annot as annot from aggJoin4993324097962734627 join aggView484897216971134583 using(v1);
select SUM(annot) as v9 from aggJoin2291075598183985028;
