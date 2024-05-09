create or replace view aggView7128357132253746553 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6832793654450809049 as select movie_id as v12 from movie_keyword as mk, aggView7128357132253746553 where mk.keyword_id=aggView7128357132253746553.v18;
create or replace view aggView7120461225606152045 as select v12, COUNT(*) as annot from aggJoin6832793654450809049 group by v12;
create or replace view aggJoin9092622189851364051 as select id as v12, annot from title as t, aggView7120461225606152045 where t.id=aggView7120461225606152045.v12;
create or replace view aggView8567269875226908266 as select v12, SUM(annot) as annot from aggJoin9092622189851364051 group by v12;
create or replace view aggJoin3017371705162211827 as select company_id as v1, annot from movie_companies as mc, aggView8567269875226908266 where mc.movie_id=aggView8567269875226908266.v12;
create or replace view aggView4507941397084585038 as select v1, SUM(annot) as annot from aggJoin3017371705162211827 group by v1;
create or replace view aggJoin3899689281498854998 as select country_code as v3, annot from company_name as cn, aggView4507941397084585038 where cn.id=aggView4507941397084585038.v1 and country_code= '[de]';
select SUM(annot) as v31 from aggJoin3899689281498854998;
