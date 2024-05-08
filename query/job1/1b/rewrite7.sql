create or replace view aggView1258955388441778422 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4774610325813897811 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1258955388441778422 where mi_idx.info_type_id=aggView1258955388441778422.v3;
create or replace view aggView2490221114369818907 as select v15 from aggJoin4774610325813897811 group by v15;
create or replace view aggJoin2449496739562410417 as select id as v15, title as v16, production_year as v19 from title as t, aggView2490221114369818907 where t.id=aggView2490221114369818907.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView1676069790978382786 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2449496739562410417 group by v15;
create or replace view aggJoin1218876499542799381 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1676069790978382786 where mc.movie_id=aggView1676069790978382786.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1425828199807818289 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2243593140072415514 as select v9, v28, v29 from aggJoin1218876499542799381 join aggView1425828199807818289 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2243593140072415514;
