## AggReduce Phase: 

# AggReduce81
# 1. aggView
create or replace view aggView3660745197819341628 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin3702721272330091936 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3660745197819341628 where Message_hasCreator_Person.MessageId=aggView3660745197819341628.v1;

# AggReduce82
# 1. aggView
create or replace view aggView8144097513076809204 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin825083518127941303 as select v1, aggJoin3702721272330091936.annot * aggView8144097513076809204.annot as annot from aggJoin3702721272330091936 join aggView8144097513076809204 using(v1);

# AggReduce83
# 1. aggView
create or replace view aggView7756974401596655423 as select v1, SUM(annot) as annot from aggJoin825083518127941303 group by v1;
# 2. aggJoin
create or replace view aggJoin3583007553299891531 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7756974401596655423 where Comment_replyOf_Message.ParentMessageId=aggView7756974401596655423.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3583007553299891531;

# drop view aggView3660745197819341628, aggJoin3702721272330091936, aggView8144097513076809204, aggJoin825083518127941303, aggView7756974401596655423, aggJoin3583007553299891531;
