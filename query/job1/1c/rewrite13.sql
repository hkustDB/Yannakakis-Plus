create or replace view aggView2446516187138403897 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin1064818536702366385 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2446516187138403897 where mc.movie_id=aggView2446516187138403897.v15 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3685281550160371750 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin365348968173328623 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3685281550160371750 where mi_idx.info_type_id=aggView3685281550160371750.v3;
create or replace view aggView4105858006695048733 as select v15 from aggJoin365348968173328623 group by v15;
create or replace view aggJoin3443736500669813180 as select v1, v9, v28 as v28, v29 as v29 from aggJoin1064818536702366385 join aggView4105858006695048733 using(v15);
create or replace view aggView1840198411898819637 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4814189830722256778 as select v9, v28, v29 from aggJoin3443736500669813180 join aggView1840198411898819637 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4814189830722256778;
