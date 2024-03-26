create or replace view aggView2831985728264618891 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin2745115102926403125 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2831985728264618891 where mi_idx.movie_id=aggView2831985728264618891.v15;
create or replace view aggView8089323230028761868 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin8204670102556190773 as select v15, v28, v29 from aggJoin2745115102926403125 join aggView8089323230028761868 using(v3);
create or replace view aggView5478786325651281090 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7038913364710098882 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5478786325651281090 where mc.company_type_id=aggView5478786325651281090.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView61541914363566535 as select v15, MIN(v9) as v27 from aggJoin7038913364710098882 group by v15;
create or replace view aggJoin3045980036358068854 as select v28 as v28, v29 as v29, v27 from aggJoin8204670102556190773 join aggView61541914363566535 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3045980036358068854;
