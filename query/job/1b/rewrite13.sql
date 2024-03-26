create or replace view aggView3431623111451686511 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin1958767239720003986 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3431623111451686511 where mi_idx.movie_id=aggView3431623111451686511.v15;
create or replace view aggView766396974992339334 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9223175062933264285 as select movie_id as v15, note as v9 from movie_companies as mc, aggView766396974992339334 where mc.company_type_id=aggView766396974992339334.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView9095468446762423579 as select v15, MIN(v9) as v27 from aggJoin9223175062933264285 group by v15;
create or replace view aggJoin867946771687065371 as select v3, v28 as v28, v29 as v29, v27 from aggJoin1958767239720003986 join aggView9095468446762423579 using(v15);
create or replace view aggView8591951498108615169 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7000761842513505938 as select v28, v29, v27 from aggJoin867946771687065371 join aggView8591951498108615169 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7000761842513505938;
