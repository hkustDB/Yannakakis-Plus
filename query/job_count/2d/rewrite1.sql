create or replace view aggView8850696906405479030 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3082680459212383869 as select movie_id as v12 from movie_keyword as mk, aggView8850696906405479030 where mk.keyword_id=aggView8850696906405479030.v18;
create or replace view aggView2394508832048471663 as select v12, COUNT(*) as annot from aggJoin3082680459212383869 group by v12;
create or replace view aggJoin5998296613840916634 as select id as v12, annot from title as t, aggView2394508832048471663 where t.id=aggView2394508832048471663.v12;
create or replace view aggView3070446066267970962 as select v12, SUM(annot) as annot from aggJoin5998296613840916634 group by v12;
create or replace view aggJoin8467989041514004889 as select company_id as v1, annot from movie_companies as mc, aggView3070446066267970962 where mc.movie_id=aggView3070446066267970962.v12;
create or replace view aggView3066701416561851827 as select v1, SUM(annot) as annot from aggJoin8467989041514004889 group by v1;
create or replace view aggJoin6542607434882475117 as select country_code as v3, annot from company_name as cn, aggView3066701416561851827 where cn.id=aggView3066701416561851827.v1 and country_code= '[us]';
select SUM(annot) as v31 from aggJoin6542607434882475117;
