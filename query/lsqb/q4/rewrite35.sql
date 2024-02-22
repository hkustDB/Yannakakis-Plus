create or replace view aggView6502985488543892950 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6451791867072381793 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6502985488543892950 where Message_hasTag_Tag.MessageId=aggView6502985488543892950.v1;
create or replace view aggView8487196470731637654 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2422854184206281668 as select v1, aggJoin6451791867072381793.annot * aggView8487196470731637654.annot as annot from aggJoin6451791867072381793 join aggView8487196470731637654 using(v1);
create or replace view aggView7214331237110386641 as select v1, SUM(annot) as annot from aggJoin2422854184206281668 group by v1;
create or replace view aggJoin3356683626445119435 as select annot from Person_likes_Message as Person_likes_Message, aggView7214331237110386641 where Person_likes_Message.MessageId=aggView7214331237110386641.v1;
select SUM(annot) as v9 from aggJoin3356683626445119435;
