create or replace view aggView3135797010420327967 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2179408580068000892 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView3135797010420327967 where mc.movie_id=aggView3135797010420327967.v12;
create or replace view aggView1769882368859809225 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3609525933803690696 as select movie_id as v12 from movie_keyword as mk, aggView1769882368859809225 where mk.keyword_id=aggView1769882368859809225.v18;
create or replace view aggView6301009517744892322 as select v12 from aggJoin3609525933803690696 group by v12;
create or replace view aggJoin8259636235797689301 as select v1, v31 as v31 from aggJoin2179408580068000892 join aggView6301009517744892322 using(v12);
create or replace view aggView795563248977245892 as select v1, MIN(v31) as v31 from aggJoin8259636235797689301 group by v1;
create or replace view aggJoin569308372568701220 as select country_code as v3, v31 from company_name as cn, aggView795563248977245892 where cn.id=aggView795563248977245892.v1 and country_code= '[us]';
select MIN(v31) as v31 from aggJoin569308372568701220;
