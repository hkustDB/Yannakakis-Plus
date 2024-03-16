create or replace view aggView2043380667125669349 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5897144221594077491 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2043380667125669349 where mk.movie_id=aggView2043380667125669349.v12;
create or replace view aggView8252143733595161724 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin156446262961686907 as select movie_id as v12 from movie_companies as mc, aggView8252143733595161724 where mc.company_id=aggView8252143733595161724.v1;
create or replace view aggView1937689975914535805 as select v12 from aggJoin156446262961686907 group by v12;
create or replace view aggJoin6534250506937457105 as select v18, v31 as v31 from aggJoin5897144221594077491 join aggView1937689975914535805 using(v12);
create or replace view aggView3526182469361865177 as select v18, MIN(v31) as v31 from aggJoin6534250506937457105 group by v18;
create or replace view aggJoin7509562947745353744 as select keyword as v9, v31 from keyword as k, aggView3526182469361865177 where k.id=aggView3526182469361865177.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin7509562947745353744;
