create or replace view aggJoin7119848784456339963 as (
with aggView7032164251546641978 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView7032164251546641978 where mc.company_id=aggView7032164251546641978.v17);
create or replace view aggJoin3388131007918923445 as (
with aggView7409677774884654640 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView7409677774884654640 where mk.keyword_id=aggView7409677774884654640.v22);
create or replace view aggJoin9216472054146714003 as (
with aggView5497334874778459737 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin7119848784456339963 join aggView5497334874778459737 using(v18));
create or replace view aggJoin183815896880835039 as (
with aggView4528238069626379295 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView4528238069626379295 where ml.link_type_id=aggView4528238069626379295.v13);
create or replace view aggJoin8508513906269090089 as (
with aggView1684547686858969474 as (select v24 from aggJoin183815896880835039 group by v24)
select v24, v19, v39 as v39 from aggJoin9216472054146714003 join aggView1684547686858969474 using(v24));
create or replace view aggJoin4901256227749908721 as (
with aggView521060725924005706 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin8508513906269090089 group by v24,v39)
select id as v24, title as v28, production_year as v31, v39, v40 from title as t, aggView521060725924005706 where t.id=aggView521060725924005706.v24 and production_year>1950);
create or replace view aggJoin3535654587918225788 as (
with aggView5447837707056826620 as (select v24, MIN(v39) as v39, MIN(v40) as v40, MIN(v28) as v41 from aggJoin4901256227749908721 group by v24,v39,v40)
select v39, v40, v41 from aggJoin3388131007918923445 join aggView5447837707056826620 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin3535654587918225788;
