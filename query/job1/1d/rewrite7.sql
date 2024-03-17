create or replace view aggView1444736893144472506 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1857633869209239821 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1444736893144472506 where mc.company_type_id=aggView1444736893144472506.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5788776639580394562 as select v15, MIN(v9) as v27 from aggJoin1857633869209239821 group by v15;
create or replace view aggJoin178617992832564976 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView5788776639580394562 where t.id=aggView5788776639580394562.v15 and production_year>2000;
create or replace view aggView3236742567535161401 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin178617992832564976 group by v15;
create or replace view aggJoin3317640405220999349 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView3236742567535161401 where mi_idx.movie_id=aggView3236742567535161401.v15;
create or replace view aggView6758499330465926478 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7336153366688719578 as select v27, v28, v29 from aggJoin3317640405220999349 join aggView6758499330465926478 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7336153366688719578;
