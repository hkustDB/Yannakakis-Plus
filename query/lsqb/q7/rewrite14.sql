create or replace view aggView2174300674215612897 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3893179013463939335 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2174300674215612897 where Message_hasTag_Tag.MessageId=aggView2174300674215612897.v1;
create or replace view aggView7854393900796783149 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7220776091281086166 as select v1, aggJoin3893179013463939335.annot * aggView7854393900796783149.annot as annot from aggJoin3893179013463939335 join aggView7854393900796783149 using(v1);
create or replace view aggView8107779138577467149 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3656198707632680808 as select aggJoin7220776091281086166.annot * aggView8107779138577467149.annot as annot from aggJoin7220776091281086166 join aggView8107779138577467149 using(v1);
select SUM(annot) as v9 from aggJoin3656198707632680808;
