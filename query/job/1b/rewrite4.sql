create or replace view aggView5623529112569164596 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin474362448734502106 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5623529112569164596 where mc.movie_id=aggView5623529112569164596.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3146145787599074323 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2940251719971072794 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3146145787599074323 where mi_idx.info_type_id=aggView3146145787599074323.v3;
create or replace view aggView6793142336983137555 as select v15 from aggJoin2940251719971072794 group by v15;
create or replace view aggJoin3753269803539602554 as select v1, v9, v28 as v28, v29 as v29 from aggJoin474362448734502106 join aggView6793142336983137555 using(v15);
create or replace view aggView6555812722571841652 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6948740387550101840 as select v9, v28, v29 from aggJoin3753269803539602554 join aggView6555812722571841652 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6948740387550101840;
