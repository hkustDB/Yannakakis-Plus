create or replace view aggView530335748402251673 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin6907360304155110002 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView530335748402251673 where mc.movie_id=aggView530335748402251673.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4832924299263957624 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3593949696233319464 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4832924299263957624 where mi_idx.info_type_id=aggView4832924299263957624.v3;
create or replace view aggView3061048625387716916 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8388764896240229132 as select v15, v9, v28, v29 from aggJoin6907360304155110002 join aggView3061048625387716916 using(v1);
create or replace view aggView6495055384935171787 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin8388764896240229132 group by v15;
create or replace view aggJoin4275111607004975325 as select v28, v29, v27 from aggJoin3593949696233319464 join aggView6495055384935171787 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4275111607004975325;
