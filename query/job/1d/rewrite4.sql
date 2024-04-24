create or replace view aggView8804999027827254907 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5468827553147822567 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8804999027827254907 where mc.company_type_id=aggView8804999027827254907.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView1167419604139883825 as select v15, MIN(v9) as v27 from aggJoin5468827553147822567 group by v15;
create or replace view aggJoin4609829940164954821 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView1167419604139883825 where mi_idx.movie_id=aggView1167419604139883825.v15;
create or replace view aggView2232476314511008853 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8403296811957620560 as select v15, v27 from aggJoin4609829940164954821 join aggView2232476314511008853 using(v3);
create or replace view aggView3898715173975650076 as select v15, MIN(v27) as v27 from aggJoin8403296811957620560 group by v15,v27;
create or replace view aggJoin5287616024893877181 as select title as v16, production_year as v19, v27 from title as t, aggView3898715173975650076 where t.id=aggView3898715173975650076.v15 and production_year>2000;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5287616024893877181;
