## AggReduce Phase: 

# AggReduce117
# 1. aggView
create or replace view aggView7627586240216752177 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin1934306348585028392 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7627586240216752177 where Message_hasTag_Tag.MessageId=aggView7627586240216752177.v1;

# AggReduce118
# 1. aggView
create or replace view aggView307229813057258094 as select v1, SUM(annot) as annot from aggJoin1934306348585028392 group by v1;
# 2. aggJoin
create or replace view aggJoin3347259875751275268 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView307229813057258094 where Message_hasCreator_Person.MessageId=aggView307229813057258094.v1;

# AggReduce119
# 1. aggView
create or replace view aggView2602606009365853505 as select v1, SUM(annot) as annot from aggJoin3347259875751275268 group by v1;
# 2. aggJoin
create or replace view aggJoin2306437593445844820 as select annot from Person_likes_Message as Person_likes_Message, aggView2602606009365853505 where Person_likes_Message.MessageId=aggView2602606009365853505.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2306437593445844820;

# drop view aggView7627586240216752177, aggJoin1934306348585028392, aggView307229813057258094, aggJoin3347259875751275268, aggView2602606009365853505, aggJoin2306437593445844820;
