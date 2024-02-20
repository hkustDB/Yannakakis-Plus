## AggReduce Phase: 

# AggReduce150
# 1. aggView
create or replace view aggView7115820362679903413 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin4244234340543844675 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7115820362679903413 where Message_hasCreator_Person.MessageId=aggView7115820362679903413.v1;

# AggReduce151
# 1. aggView
create or replace view aggView187347615547970424 as select v1, SUM(annot) as annot from aggJoin4244234340543844675 group by v1;
# 2. aggJoin
create or replace view aggJoin8813146099527019397 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView187347615547970424 where Comment_replyOf_Message.ParentMessageId=aggView187347615547970424.v1;

# AggReduce152
# 1. aggView
create or replace view aggView7691740295366467072 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin3298719106245442168 as select aggJoin8813146099527019397.annot * aggView7691740295366467072.annot as annot from aggJoin8813146099527019397 join aggView7691740295366467072 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin3298719106245442168;

# drop view aggView7115820362679903413, aggJoin4244234340543844675, aggView187347615547970424, aggJoin8813146099527019397, aggView7691740295366467072, aggJoin3298719106245442168;
