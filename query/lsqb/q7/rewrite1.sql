## AggReduce Phase: 

# AggReduce3
# 1. aggView
create or replace view aggView7496243269898908450 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin2812009581014057392 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7496243269898908450 where Message_hasTag_Tag.MessageId=aggView7496243269898908450.v1;

# AggReduce4
# 1. aggView
create or replace view aggView5687510487979284647 as select v1, SUM(annot) as annot from aggJoin2812009581014057392 group by v1;
# 2. aggJoin
create or replace view aggJoin3872786808041679027 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5687510487979284647 where Person_likes_Message.MessageId=aggView5687510487979284647.v1;

# AggReduce5
# 1. aggView
create or replace view aggView150725826457924300 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2295028925908324225 as select aggJoin3872786808041679027.annot * aggView150725826457924300.annot as annot from aggJoin3872786808041679027 join aggView150725826457924300 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2295028925908324225;

# drop view aggView7496243269898908450, aggJoin2812009581014057392, aggView5687510487979284647, aggJoin3872786808041679027, aggView150725826457924300, aggJoin2295028925908324225;
