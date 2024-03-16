create or replace view aggView4062875408680520871 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin4064571507699804724 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView4062875408680520871 where mk.movie_id=aggView4062875408680520871.v14;
create or replace view aggView1491466136211229563 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3928904947066259872 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1491466136211229563 where mi_idx.info_type_id=aggView1491466136211229563.v1 and info>'9.0';
create or replace view aggView1862654696848105491 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6047235216065331690 as select v14, v27 from aggJoin4064571507699804724 join aggView1862654696848105491 using(v3);
create or replace view aggView1389251721812782850 as select v14, MIN(v27) as v27 from aggJoin6047235216065331690 group by v14;
create or replace view aggJoin4811546691535085058 as select v9, v27 from aggJoin3928904947066259872 join aggView1389251721812782850 using(v14);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin4811546691535085058;
