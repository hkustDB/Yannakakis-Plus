create or replace view aggView2800584293230519403 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8875046907557039124 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2800584293230519403 where mc.company_type_id=aggView2800584293230519403.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4908425240378978512 as select v15, MIN(v9) as v27 from aggJoin8875046907557039124 group by v15;
create or replace view aggJoin6703123281949738326 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView4908425240378978512 where t.id=aggView4908425240378978512.v15 and production_year>2000;
create or replace view aggView3151318296696529493 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6703123281949738326 group by v15;
create or replace view aggJoin4003534959284098059 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView3151318296696529493 where mi_idx.movie_id=aggView3151318296696529493.v15;
create or replace view aggView1511906403631726474 as select v3, MIN(v27) as v27, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4003534959284098059 group by v3;
create or replace view aggJoin5507797575542660182 as select v27, v28, v29 from info_type as it, aggView1511906403631726474 where it.id=aggView1511906403631726474.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5507797575542660182;
