export type Offering={id:string;name:string;offering_type:string;description:string;target_audience:string;scheduled_date:string|null;price_display:string|null;location_or_format:string|null;brand_voice_id:string|null};
export type Campaign={id:string;title:string;status:string;exported_at:string|null;offerings:Offering|null};
export type Piece={id:string;campaign_id:string;piece_type:string;content_value:string;edited_value:string|null;content_confidence:number;review_status:string;word_count:number|null};
export type BrandVoice={id:string;practitioner_name:string;modality:string;tone:string;keywords:string[];avoid_phrases:string[];about_blurb:string};
export const pieceLabels:Record<string,string>={instagram_caption:"Instagram caption",carousel_copy:"Carousel copy",reel_script:"Reel script",whatsapp_broadcast:"WhatsApp broadcast",email:"Email"};
