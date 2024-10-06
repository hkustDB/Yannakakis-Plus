create or replace view semiUp7609446231479158669 as select CommentId as v3, ParentMessageId as v1 from Comment_replyOf_Message AS Comment_replyOf_Message where (ParentMessageId) in (select (MessageId) from Message_hasTag_Tag AS Message_hasTag_Tag);
create or replace view semiUp6062972947012011277 as select CommentId as v3, TagId as cht_TagId from Comment_hasTag_Tag AS cht where (CommentId) in (select (v3) from semiUp7609446231479158669);
create or replace view semiDown7987526227466155825 as select v3, v1 from semiUp7609446231479158669 where (v3) in (select (v3) from semiUp6062972947012011277);
create or replace view semiDown8256732079809813469 as select MessageId as v1, TagId as M_TagId from Message_hasTag_Tag AS Message_hasTag_Tag where (MessageId) in (select (v1) from semiDown7987526227466155825);
create or replace view aggView3521918215019074688 as select v1, M_TagId, COUNT(*) as annot from semiDown8256732079809813469 group by v1, M_TagId;
create or replace view aggJoin3063382859002246477 as select v3, M_TagId, annot from semiDown7987526227466155825 join aggView3521918215019074688 using(v1);
create or replace view aggView208811782423232673 as select v3, M_TagId, SUM(annot) as annot from aggJoin3063382859002246477 group by v3, M_TagId;
create or replace view aggJoin780353700482570686 as select annot from semiUp6062972947012011277 join aggView208811782423232673 using(v3) where M_TagId < cht_TagId;
select SUM(annot) as v7 from aggJoin780353700482570686;
