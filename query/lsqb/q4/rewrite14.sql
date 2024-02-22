create or replace view aggView7132561876926042613 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin288645177700286506 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7132561876926042613 where Comment_replyOf_Message.ParentMessageId=aggView7132561876926042613.v1;
create or replace view aggView854257604446195719 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin8690556070988801356 as select v1, aggJoin288645177700286506.annot * aggView854257604446195719.annot as annot from aggJoin288645177700286506 join aggView854257604446195719 using(v1);
create or replace view aggView7544464865201083419 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7836757876062930818 as select aggJoin8690556070988801356.annot * aggView7544464865201083419.annot as annot from aggJoin8690556070988801356 join aggView7544464865201083419 using(v1);
select SUM(annot) as v9 from aggJoin7836757876062930818;
