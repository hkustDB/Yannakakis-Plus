create or replace view aggView786624704650991611 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin2195672322894318319 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView786624704650991611 where mc.movie_id=aggView786624704650991611.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView2717963990410142380 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2387981092126000124 as select v15, v9, v28, v29 from aggJoin2195672322894318319 join aggView2717963990410142380 using(v1);
create or replace view aggView5603926134808056794 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2387981092126000124 group by v15;
create or replace view aggJoin5732180668627614912 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView5603926134808056794 where mi_idx.movie_id=aggView5603926134808056794.v15;
create or replace view aggView845483965886664026 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin5732180668627614912 group by v3;
create or replace view aggJoin1713211151407281964 as select info as v4, v28, v29, v27 from info_type as it, aggView845483965886664026 where it.id=aggView845483965886664026.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1713211151407281964;
