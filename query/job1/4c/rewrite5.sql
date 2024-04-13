create or replace view aggView1301834392884258373 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin6809193362074062928 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView1301834392884258373 where mi_idx.movie_id=aggView1301834392884258373.v14 and info>'2.0';
create or replace view aggView3765652797725401142 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3438556053101151489 as select v14, v9, v27 from aggJoin6809193362074062928 join aggView3765652797725401142 using(v1);
create or replace view aggView8139825295323953106 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3438556053101151489 group by v14,v27;
create or replace view aggJoin4763802898220400617 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView8139825295323953106 where mk.movie_id=aggView8139825295323953106.v14;
create or replace view aggView8040028262809191338 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1694229923829279201 as select v27, v26 from aggJoin4763802898220400617 join aggView8040028262809191338 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1694229923829279201;
