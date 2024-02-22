create or replace view aggView5655124462952911095 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8668342132210182603 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5655124462952911095 where Message_hasTag_Tag.MessageId=aggView5655124462952911095.v1;
create or replace view aggView8033903672045870916 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3385959201454866948 as select v1, aggJoin8668342132210182603.annot * aggView8033903672045870916.annot as annot from aggJoin8668342132210182603 join aggView8033903672045870916 using(v1);
create or replace view aggView7026837545549068556 as select v1, SUM(annot) as annot from aggJoin3385959201454866948 group by v1;
create or replace view aggJoin6842859700841784683 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7026837545549068556 where Comment_replyOf_Message.ParentMessageId=aggView7026837545549068556.v1;
select SUM(annot) as v9 from aggJoin6842859700841784683;
