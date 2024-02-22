create or replace view aggView2720683626821470417 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4257263382063475787 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2720683626821470417 where Comment_replyOf_Message.ParentMessageId=aggView2720683626821470417.v1;
create or replace view aggView5158833102145216542 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin1543810278343237564 as select v1, aggJoin4257263382063475787.annot * aggView5158833102145216542.annot as annot from aggJoin4257263382063475787 join aggView5158833102145216542 using(v1);
create or replace view aggView185774579863361661 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin8828032930869377773 as select aggJoin1543810278343237564.annot * aggView185774579863361661.annot as annot from aggJoin1543810278343237564 join aggView185774579863361661 using(v1);
select SUM(annot) as v9 from aggJoin8828032930869377773;
