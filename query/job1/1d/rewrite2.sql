create or replace view aggView529145901791400109 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin2065680048214019002 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView529145901791400109 where mc.movie_id=aggView529145901791400109.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5524322536853829727 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2249380811035083020 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5524322536853829727 where mi_idx.info_type_id=aggView5524322536853829727.v3;
create or replace view aggView5724727936460689421 as select v15 from aggJoin2249380811035083020 group by v15;
create or replace view aggJoin250309133494115828 as select v1, v9, v28 as v28, v29 as v29 from aggJoin2065680048214019002 join aggView5724727936460689421 using(v15);
create or replace view aggView7628970589622880189 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin250309133494115828 group by v1;
create or replace view aggJoin991452899671774683 as select kind as v2, v28, v29, v27 from company_type as ct, aggView7628970589622880189 where ct.id=aggView7628970589622880189.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin991452899671774683;
