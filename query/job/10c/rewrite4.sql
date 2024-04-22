create or replace view aggView2680983029429664248 as select name as v2, id as v1 from char_name as chn;
create or replace view aggView3030406012017007208 as select id as v31, title as v32 from title as t where production_year>1990;
create or replace view aggJoin3870041739062451491 as (
with aggView2729737262022910351 as (select v31, MIN(v32) as v44 from aggView3030406012017007208 group by v31)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView2729737262022910351 where ci.movie_id=aggView2729737262022910351.v31 and note LIKE '%(producer)%');
create or replace view aggJoin6021965948627933787 as (
with aggView2343127795592966999 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView2343127795592966999 where mc.company_type_id=aggView2343127795592966999.v22);
create or replace view aggJoin6033738733119096933 as (
with aggView7258601223163205337 as (select id as v29 from role_type as rt)
select v31, v1, v12, v44 from aggJoin3870041739062451491 join aggView7258601223163205337 using(v29));
create or replace view aggJoin6360168987290615665 as (
with aggView4792174925693685204 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31 from aggJoin6021965948627933787 join aggView4792174925693685204 using(v15));
create or replace view aggJoin7359577704269902771 as (
with aggView8926453437830402825 as (select v31 from aggJoin6360168987290615665 group by v31)
select v1, v12, v44 as v44 from aggJoin6033738733119096933 join aggView8926453437830402825 using(v31));
create or replace view aggJoin5204191502275962430 as (
with aggView1927761254421880171 as (select v1, MIN(v44) as v44 from aggJoin7359577704269902771 group by v1,v44)
select v2, v44 from aggView2680983029429664248 join aggView1927761254421880171 using(v1));
select MIN(v2) as v43,MIN(v44) as v44 from aggJoin5204191502275962430;
