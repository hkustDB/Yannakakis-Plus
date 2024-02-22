create or replace view aggView2987574096294762738 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2619911611826934367 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2987574096294762738 where Comment_replyOf_Message.ParentMessageId=aggView2987574096294762738.v1;
create or replace view aggView3472962628561702249 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2974173676781099094 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3472962628561702249 where Message_hasTag_Tag.MessageId=aggView3472962628561702249.v1;
create or replace view aggView2138415582271434295 as select v1, SUM(annot) as annot from aggJoin2974173676781099094 group by v1;
create or replace view aggJoin6003377735553677122 as select aggJoin2619911611826934367.annot * aggView2138415582271434295.annot as annot from aggJoin2619911611826934367 join aggView2138415582271434295 using(v1);
select SUM(annot) as v9 from aggJoin6003377735553677122;
