## AggReduce Phase: 

# AggReduce21
# 1. aggView
create or replace view aggView2043243724431421999 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6428121594011716001 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2043243724431421999 where Message_hasTag_Tag.MessageId=aggView2043243724431421999.v1;

# AggReduce22
# 1. aggView
create or replace view aggView7131545687252333815 as select v1, SUM(annot) as annot from aggJoin6428121594011716001 group by v1;
# 2. aggJoin
create or replace view aggJoin858899564053890260 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7131545687252333815 where Comment_replyOf_Message.ParentMessageId=aggView7131545687252333815.v1;

# AggReduce23
# 1. aggView
create or replace view aggView228792237039447153 as select v1, SUM(annot) as annot from aggJoin858899564053890260 group by v1;
# 2. aggJoin
create or replace view aggJoin8274418659312339898 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView228792237039447153 where Message_hasCreator_Person.MessageId=aggView228792237039447153.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8274418659312339898;

# drop view aggView2043243724431421999, aggJoin6428121594011716001, aggView7131545687252333815, aggJoin858899564053890260, aggView228792237039447153, aggJoin8274418659312339898;
