create or replace view aggView310114548989960830 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7106495904520430623 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView310114548989960830 where mc.movie_id=aggView310114548989960830.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1677149464012141293 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4236541640165974435 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1677149464012141293 where mi_idx.info_type_id=aggView1677149464012141293.v3;
create or replace view aggView8395233768632884532 as select v15 from aggJoin4236541640165974435 group by v15;
create or replace view aggJoin3134036863977067510 as select v1, v9, v28 as v28, v29 as v29 from aggJoin7106495904520430623 join aggView8395233768632884532 using(v15);
create or replace view aggView7309864832694335781 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6665151191245975972 as select v9, v28, v29 from aggJoin3134036863977067510 join aggView7309864832694335781 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6665151191245975972;
