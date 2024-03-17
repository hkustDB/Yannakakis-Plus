create or replace view aggView1144615211299175851 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin4686816954614033478 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView1144615211299175851 where mk.movie_id=aggView1144615211299175851.v14;
create or replace view aggView3977372888173251038 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1306359444655875735 as select v14, v27 from aggJoin4686816954614033478 join aggView3977372888173251038 using(v3);
create or replace view aggView8971112127245888684 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5150461612470701877 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8971112127245888684 where mi_idx.info_type_id=aggView8971112127245888684.v1 and info>'2.0';
create or replace view aggView1636605275876235823 as select v14, MIN(v9) as v26 from aggJoin5150461612470701877 group by v14;
create or replace view aggJoin5981000160761794962 as select v27 as v27, v26 from aggJoin1306359444655875735 join aggView1636605275876235823 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5981000160761794962;
