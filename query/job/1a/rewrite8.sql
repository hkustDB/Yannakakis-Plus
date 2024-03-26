create or replace view aggView8900067044332183923 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin3569900469409331025 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView8900067044332183923 where mi_idx.movie_id=aggView8900067044332183923.v15;
create or replace view aggView3671903515435198995 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4958279169027332672 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3671903515435198995 where mc.company_type_id=aggView3671903515435198995.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView3381753564710568660 as select v15, MIN(v9) as v27 from aggJoin4958279169027332672 group by v15;
create or replace view aggJoin4231733427694876200 as select v3, v28 as v28, v29 as v29, v27 from aggJoin3569900469409331025 join aggView3381753564710568660 using(v15);
create or replace view aggView4723803173457221660 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin4231733427694876200 group by v3;
create or replace view aggJoin9037284623886285147 as select info as v4, v28, v29, v27 from info_type as it, aggView4723803173457221660 where it.id=aggView4723803173457221660.v3 and info= 'top 250 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin9037284623886285147;
