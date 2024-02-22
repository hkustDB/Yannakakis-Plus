create or replace view aggView9166296455383462919 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2273676851906715626 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView9166296455383462919 where Person_likes_Message.MessageId=aggView9166296455383462919.v1;
create or replace view aggView1839687700465724385 as select v1, SUM(annot) as annot from aggJoin2273676851906715626 group by v1;
create or replace view aggJoin4972316434439224622 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1839687700465724385 where Message_hasTag_Tag.MessageId=aggView1839687700465724385.v1;
create or replace view aggView3379332619421046010 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin616712781449521042 as select aggJoin4972316434439224622.annot * aggView3379332619421046010.annot as annot from aggJoin4972316434439224622 join aggView3379332619421046010 using(v1);
select SUM(annot) as v9 from aggJoin616712781449521042;
