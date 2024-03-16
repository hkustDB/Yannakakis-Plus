create or replace view aggView3583520298557172758 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin3574181490487101069 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3583520298557172758 where mi_idx.movie_id=aggView3583520298557172758.v14 and info>'9.0';
create or replace view aggView5194568352727805989 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3511410739537761071 as select v14, v9, v27 from aggJoin3574181490487101069 join aggView5194568352727805989 using(v1);
create or replace view aggView1872397618706975460 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8494982271883030187 as select movie_id as v14 from movie_keyword as mk, aggView1872397618706975460 where mk.keyword_id=aggView1872397618706975460.v3;
create or replace view aggView5411008116335670923 as select v14 from aggJoin8494982271883030187 group by v14;
create or replace view aggJoin5629203078470010582 as select v9, v27 as v27 from aggJoin3511410739537761071 join aggView5411008116335670923 using(v14);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin5629203078470010582;
