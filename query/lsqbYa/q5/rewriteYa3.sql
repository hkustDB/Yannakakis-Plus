create or replace view semiUp7996349078752184848 as select CommentId as v3, ParentMessageId as v1 from Comment_replyOf_Message AS Comment_replyOf_Message where (CommentId) in (select (CommentId) from Comment_hasTag_Tag AS cht);
create or replace view semiUp8088076232369322711 as select v3, v1 from semiUp7996349078752184848 where (v1) in (select (MessageId) from Message_hasTag_Tag AS Message_hasTag_Tag);
create or replace view semiDown3076368769386830008 as select CommentId as v3, TagId as cht_TagId from Comment_hasTag_Tag AS cht where (CommentId) in (select (v3) from semiUp8088076232369322711);
create or replace view semiDown4450108017443755081 as select MessageId as v1, TagId as M_TagId from Message_hasTag_Tag AS Message_hasTag_Tag where (MessageId) in (select (v1) from semiUp8088076232369322711);
create or replace view aggView6126322331771466986 as select v1, M_TagId, COUNT(*) as annot from semiDown4450108017443755081 group by v1, M_TagId;
create or replace view aggJoin1073921987962332727 as select v3, M_TagId, annot from semiUp8088076232369322711 join aggView6126322331771466986 using(v1);
create or replace view aggView1197395122024513035 as select v3, cht_TagId, COUNT(*) as annot from semiDown3076368769386830008 group by v3, cht_TagId;
create or replace view aggJoin1085052022145035953 as select aggJoin1073921987962332727.annot * aggView1197395122024513035.annot as annot from aggJoin1073921987962332727 join aggView1197395122024513035 using(v3) where M_TagId < cht_TagId;
select SUM(annot) as v7 from aggJoin1085052022145035953;
