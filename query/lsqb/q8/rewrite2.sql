create or replace view aggView183990511291475041 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin1335083672740583199 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView183990511291475041 where Comment_replyOf_Message.CommentId=aggView183990511291475041.v3;
create or replace view aggView2899824112020494786 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
create or replace view aggJoin5586629241322669358 as select MessageId as v1, TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2899824112020494786 where Message_hasTag_Tag.TagId=aggView2899824112020494786.v2;
create or replace view aggView1195509769361662110 as select v1, SUM(annot) as annot, v2 from aggJoin5586629241322669358 group by v1,v2;
create or replace view aggJoin4441526940712214286 as select v8, aggJoin1335083672740583199.annot * aggView1195509769361662110.annot as annot, v2 from aggJoin1335083672740583199 join aggView1195509769361662110 using(v1) where v2 < v8;
select SUM(annot) as v9 from aggJoin4441526940712214286;
