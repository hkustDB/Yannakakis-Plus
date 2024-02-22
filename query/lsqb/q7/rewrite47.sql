create or replace view aggView670512395702543934 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin179808561757377448 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView670512395702543934 where Person_likes_Message.MessageId=aggView670512395702543934.v1;
create or replace view aggView4429238001655384709 as select v1, SUM(annot) as annot from aggJoin179808561757377448 group by v1;
create or replace view aggJoin3889889081970372987 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4429238001655384709 where Comment_replyOf_Message.ParentMessageId=aggView4429238001655384709.v1;
create or replace view aggView168294485810331746 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin7135439149198716041 as select aggJoin3889889081970372987.annot * aggView168294485810331746.annot as annot from aggJoin3889889081970372987 join aggView168294485810331746 using(v1);
select SUM(annot) as v9 from aggJoin7135439149198716041;
