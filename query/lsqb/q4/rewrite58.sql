## AggReduce Phase: 

# AggReduce174
# 1. aggView
create or replace view aggView5438442213936974798 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin3357649398864894343 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5438442213936974798 where Person_likes_Message.MessageId=aggView5438442213936974798.v1;

# AggReduce175
# 1. aggView
create or replace view aggView5394442410881805056 as select v1, SUM(annot) as annot from aggJoin3357649398864894343 group by v1;
# 2. aggJoin
create or replace view aggJoin2762513330734705114 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5394442410881805056 where Message_hasTag_Tag.MessageId=aggView5394442410881805056.v1;

# AggReduce176
# 1. aggView
create or replace view aggView4580046997519951035 as select v1, SUM(annot) as annot from aggJoin2762513330734705114 group by v1;
# 2. aggJoin
create or replace view aggJoin3746873223371219033 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4580046997519951035 where Comment_replyOf_Message.ParentMessageId=aggView4580046997519951035.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3746873223371219033;

# drop view aggView5438442213936974798, aggJoin3357649398864894343, aggView5394442410881805056, aggJoin2762513330734705114, aggView4580046997519951035, aggJoin3746873223371219033;
