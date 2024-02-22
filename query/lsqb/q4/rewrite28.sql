create or replace view aggView1767757438448633026 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7025710688803957752 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView1767757438448633026 where Comment_replyOf_Message.ParentMessageId=aggView1767757438448633026.v1;
create or replace view aggView7298068098261229774 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1597925013240357883 as select v1, aggJoin7025710688803957752.annot * aggView7298068098261229774.annot as annot from aggJoin7025710688803957752 join aggView7298068098261229774 using(v1);
create or replace view aggView3009722409954521842 as select v1, SUM(annot) as annot from aggJoin1597925013240357883 group by v1;
create or replace view aggJoin1346479577769239086 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3009722409954521842 where Message_hasCreator_Person.MessageId=aggView3009722409954521842.v1;
select SUM(annot) as v9 from aggJoin1346479577769239086;
